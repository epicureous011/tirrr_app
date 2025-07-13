// lib/pages/settings_page.dart

import 'package:flutter/material.dart';
import '../components/app_header.dart';
import '../components/drawer.dart';
import 'package:url_launcher/url_launcher.dart';


const Color _primaryBlue = Color(0xFF1E2A78);
const Color _textBlack = Color(0xFF000000);

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isMatchesOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ListView(
          children: [
            // Profil Bölümü
            Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage('assets/avatar.jpg'),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'Adina Nurrahma',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _textBlack,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(color: Color(0xFFE0E0E0), thickness: 1),
            const SizedBox(height: 16),

            

            // Şifreni Sıfırla
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.lock, color: _primaryBlue, size: 24),
              title: const Text(
                'Şifreni Sıfırla',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: _textBlack,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 24),
              onTap: () => Navigator.pushNamed(context, '/forgot-password'),
            ),

            // Bize Ulaş
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.info, color: _primaryBlue, size: 24),
              title: const Text(
                'Bize Ulaş',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: _textBlack,
                ),
              ),
              trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 24),
              onTap: () async {
                final Uri whatsappUri = Uri.parse('https://wa.me/+905368644020');
                if (await canLaunchUrl(whatsappUri)) {
                  await launchUrl(whatsappUri);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}