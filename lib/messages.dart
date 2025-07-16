// lib/messages.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/app_header.dart';
import '../components/drawer.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  bool showUnreadOnly = false;

  Future<void> _ensureChat(String ilanId) async {
    final currentUid = FirebaseAuth.instance.currentUser?.uid;
    if (currentUid == null) return;
    final query = FirebaseFirestore.instance
        .collection('chats')
        .where('ilanId', isEqualTo: ilanId)
        .where('participants', arrayContains: currentUid);
    final snap = await query.get();
    if (snap.docs.isEmpty) {
      final postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(ilanId)
          .get();
      final ownerUid = postSnap.data()?['uid'] as String?;
      final participants = <String>[];
      if (ownerUid != null) participants.add(ownerUid);
      participants.add(currentUid);
      await FirebaseFirestore.instance.collection('chats').add({
        'ilanId': ilanId,
        'participants': participants,
        'createdAt': FieldValue.serverTimestamp(),
        'lastMessage': '',
        'lastMessageDate': FieldValue.serverTimestamp(),
        'unreadCount': 0,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || args is! String) {
      return Scaffold(
        appBar: const AppHeader(),
        drawer: AppDrawer(),
        body: const Center(child: Text('ilanId bulunamadı', style: TextStyle(fontSize: 16))),
      );
    }
    final ilanId = args;
    final chatsQuery = FirebaseFirestore.instance
        .collection('chats')
        .where('ilanId', isEqualTo: ilanId);

    return FutureBuilder<void>(
      future: _ensureChat(ilanId),
      builder: (context, snapshotEns) {
        if (snapshotEns.connectionState != ConnectionState.done) {
          return Scaffold(
            appBar: const AppHeader(),
            drawer: AppDrawer(),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: const AppHeader(),
          drawer: AppDrawer(),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Son Mesajlar',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF000000),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _TabButton(
                      label: 'Tümü',
                      isSelected: !showUnreadOnly,
                      onTap: () => setState(() => showUnreadOnly = false),
                    ),
                    const SizedBox(width: 8),
                    _TabButton(
                      label: 'Okunmamışlar',
                      isSelected: showUnreadOnly,
                      onTap: () => setState(() => showUnreadOnly = true),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: chatsQuery.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Hata: ${snapshot.error}'));
                      }
                      // Get documents and sort by lastMessageDate descending locally to avoid composite index requirement
                      final docsSnap = snapshot.data?.docs ?? [];
                      final sortedDocs = List<QueryDocumentSnapshot>.from(docsSnap);
                      sortedDocs.sort((a, b) {
                        final aData = a.data()! as Map<String, dynamic>;
                        final bData = b.data()! as Map<String, dynamic>;
                        final aTs = aData['lastMessageDate'] as Timestamp?;
                        final bTs = bData['lastMessageDate'] as Timestamp?;
                        final aDate = aTs?.toDate() ?? DateTime.fromMillisecondsSinceEpoch(0);
                        final bDate = bTs?.toDate() ?? DateTime.fromMillisecondsSinceEpoch(0);
                        return bDate.compareTo(aDate);
                      });
                      var items = sortedDocs;
                      if (showUnreadOnly) {
                        items = sortedDocs.where((doc) {
                          final unread = (doc.data()! as Map<String, dynamic>)['unreadCount'] as int?;
                          return unread != null && unread > 0;
                        }).toList();
                      }
                      if (items.isEmpty) {
                        return const Center(
                          child: Text(
                            'Gösterilecek sohbet yok.',
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final doc = items[index];
                          final data = doc.data()! as Map<String, dynamic>;
                          final lastMessage = data['lastMessage'] as String? ?? '';
                          final timestamp = data['lastMessageDate'] as Timestamp?;
                          final timeStr = timestamp != null
                              ? DateFormat.Hm().format(timestamp.toDate())
                              : '';
                          final unreadCount = data['unreadCount'] as int?;
                          final participantsRaw = data['participants'] as List<dynamic>? ?? [];
                          final participants = participantsRaw.whereType<String>().toList();
                          final name = participants.isNotEmpty ? participants.join(', ') : 'Bilinmeyen';

                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/message',
                                arguments: doc.id,
                              );
                            },
                            child: MessageListItem(
                              name: name,
                              message: lastMessage,
                              time: timeStr,
                              unreadCount: unreadCount,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const _TabButton({
    Key? key,
    required this.label,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF1E2A78);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: primaryBlue),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color: isSelected ? Colors.white : primaryBlue,
          ),
        ),
      ),
    );
  }
}

class MessageListItem extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final int? unreadCount;

  const MessageListItem({
    Key? key,
    required this.name,
    required this.message,
    required this.time,
    this.unreadCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF1E2A78);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: unreadCount != null ? const Color(0xFFEDEFF8) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: primaryBlue,
            child: Text(
              name.isNotEmpty ? name[0] : '',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              if (unreadCount != null && unreadCount! > 0)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: primaryBlue,
                  ),
                  child: Text(
                    '$unreadCount',
                    style: const TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}