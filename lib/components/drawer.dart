import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // 1) Main menu in a scrollable area
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildDrawerItem(context, 'Anasayfa', '/home'),
                  const Divider(height: 1, color: Colors.grey),
                  _buildDrawerItem(context, 'İlan Ara', '/search-listing'),
                  const Divider(height: 1, color: Colors.grey),
                  _buildDrawerItem(context, 'İlan Ver', '/post-listing'),
                  const Divider(height: 1, color: Colors.grey),
                  _buildDrawerItem(context, 'Mesajlar', '/messages'),
                  const Divider(height: 1, color: Colors.grey),
                  _buildDrawerItem(context, 'Bildirimler', '/notifications'),
                  const Divider(height: 1, color: Colors.grey),
                  _buildDrawerItem(context, 'Profil', '/profile'),
                  const Divider(height: 1, color: Colors.grey),
                  _buildDrawerItem(context, 'Ayarlar', '/settings'),
                ],
              ),
            ),

            // 2) A divider just above the logout
            const Divider(height: 1, color: Colors.grey),

            // 3) The logout tile stays at the bottom
            ListTile(
              title: const Text(
                'Çıkış Yap',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, String title, String routeName) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, routeName);
      },
    );
  }
}