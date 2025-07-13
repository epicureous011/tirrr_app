// lib/messages.dart
import 'package:flutter/material.dart';
import '../components/app_header.dart';
import '../components/drawer.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  bool showUnreadOnly = false;

  final List<Map<String, dynamic>> _messages = [
    {
      'id': 1,
      'name': 'Suzan Kılıç',
      'message': 'Merhaba!',
      'time': '18:31',
      'unreadCount': 5,
      'statusColor': Colors.yellow,
    },
    {
      'id': 2,
      'name': 'Ahmet Yiğit',
      'message': 'Merhaba!',
      'time': '16:04',
      'unreadCount': null,
      'statusColor': null,
    },
    {
      'id': 3,
      'name': 'Hasan Demir',
      'message': 'Merhaba!',
      'time': '06:12',
      'unreadCount': null,
      'statusColor': Colors.green,
    },
    // ... add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = showUnreadOnly
        ? _messages.where((m) => m['unreadCount'] != null && (m['unreadCount'] as int) > 0).toList()
        : _messages;

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
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E2A78),
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
              child: ListView(
                children: filtered.map((m) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/message',
                        arguments: m['id'],
                      );
                    },
                    child: MessageListItem(
                      name: m['name'] as String,
                      message: m['message'] as String,
                      time: m['time'] as String,
                      unreadCount: m['unreadCount'] as int?,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle new message action
        },
        backgroundColor: const Color(0xFF1E2A78),
        child: const Icon(Icons.add_comment),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const _TabButton({
    super.key,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E2A78) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF1E2A78)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF1E2A78),
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
    super.key,
    required this.name,
    required this.message,
    required this.time,
    this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
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
            backgroundColor: Colors.blue,
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
                    color: Color(0xFF1E2A78),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
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
              if (unreadCount != null)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1E2A78),
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