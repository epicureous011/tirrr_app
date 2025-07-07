import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
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
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, String routeName) {
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