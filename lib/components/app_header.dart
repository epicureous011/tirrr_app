import 'package:flutter/material.dart';

/// Uygulamanın üst kısmındaki başlık bileşeni.
/// Menü ve arama ikonları ile ortada logo yer alır.
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  /// Menü butonuna tıklandığında çalışacak geri çağırım.
  final VoidCallback? onMenuTap;

  /// Arama butonuna tıklandığında çalışacak geri çağırım.
  final VoidCallback? onSearchTap;

  const AppHeader({Key? key, this.onMenuTap, this.onSearchTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Builder(
              builder: (context) => IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),

            // Logo ve uygulama adı
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/home'),
                    child: Image.asset(
                      'assets/ic_truck.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Uygulama adı (turuncu) - Görselde "Tırrr"
                ],
              ),
            ),

            // Arama ikonu
            IconButton(
              icon: SizedBox.shrink(),
              onPressed: () {
                // optionally handle tap, or leave empty
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
