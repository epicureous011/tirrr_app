import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'components/app_header.dart';
import 'components/drawer.dart';
//buradayız
class ListingPage extends StatelessWidget {
  const ListingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ilanId = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppHeader(),
      drawer: AppDrawer(),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('posts')
            .doc(ilanId)
            .get(),
        builder: (context, postSnapshot) {
          if (postSnapshot.hasError) {
            return Center(child: Text('Error: ${postSnapshot.error}'));
          }
          if (postSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final postData = postSnapshot.data!.data() as Map<String, dynamic>? ?? {};
          final dynamic ilanNo = postData['id']?.toString() ?? ilanId;
          final uid = postData['uid'] as String?;
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(uid)
                .get(),
            builder: (context, userSnapshot) {
              String fullName = '';
              if (userSnapshot.hasError) {
                fullName = '';
              } else if (userSnapshot.hasData && userSnapshot.data!.exists) {
                final userData = userSnapshot.data!.data() as Map<String, dynamic>? ?? {};
                final first = userData['firstName'] as String? ?? '';
                final second = userData['secondName'] as String? ?? '';
                fullName = [first, second].where((s) => s.isNotEmpty).join(' ');
              }
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Sayfa Başlığı
                            Text(
                              'İlan #$ilanNo',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E2A78),
                              ),
                            ),
                            const SizedBox(height: 24),
                            // İlan Sahibi Bilgileri
                            Text(
                              'İlan Sahibi Bilgileri',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              fullName.isNotEmpty ? fullName : 'İsim bulunamadı',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Divider(color: Colors.grey),
                            const SizedBox(height: 16),
                            // İlan Bilgileri (rest unchanged)
                            Text(
                              'İlan Bilgileri',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _buildInfoRow('İçerik', 'Mobilya'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Kilo', '20 ton'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Kalkış Başlangıç Tarihi', '24 Mayıs'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Kalkış Bitiş Tarihi', '1 Haziran'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Kalkış Noktası', 'Konya'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Varış Noktası', 'İstanbul'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Ücret', '15000 + KDV'),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                    // Mesaj At Butonu
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/chat',
                              arguments: ilanId,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E2A78),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Mesaj At',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}