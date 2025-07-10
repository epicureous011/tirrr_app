import 'package:flutter/material.dart';
import 'components/app_header.dart';
import 'components/drawer.dart';
//buradayız
class ListingPage extends StatelessWidget {
  const ListingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ilanId = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppHeader(),
      drawer: AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            // İçerik
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sayfa Başlığı
                    Text(
                      'İlan #$ilanId',
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
                      'Mustafa Hasan',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'İşlem Geçmişi',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '0 Adet',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(color: Colors.grey),
                    const SizedBox(height: 16),

                    // İlan Bilgileri
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
                    _buildInfoRow('Hacim', '12 bin m³'),
                    const SizedBox(height: 12),
                    _buildInfoRow('Kilo', '20 ton'),
                    const SizedBox(height: 12),
                    _buildInfoRow('Kalkış Tarihi Aralığı', '24 Mayıs – 1 Haziran'),
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