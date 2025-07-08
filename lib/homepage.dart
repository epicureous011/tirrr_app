import 'package:flutter/material.dart';
import 'components/app_header.dart';
import 'components/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppHeader(),
        drawer: AppDrawer(),
        body: Column(
          children: [
            // Sekmeler
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TabBar(
                labelColor: const Color(0xFF1E2A78),
                unselectedLabelColor: Colors.black,
                indicatorColor: const Color(0xFF1E2A78),
                indicatorWeight: 2,
                labelStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
                tabs: const [
                  Tab(text: 'Aktif'),
                  Tab(text: 'Bekleyen'),
                  Tab(text: 'Geçmiş'),
                ],
              ),
            ),
            // Tab içeriği
            Expanded(
              child: TabBarView(
                children: const [
                  _ListingTab(tabItems: aktifItems),
                  _ListingTab(tabItems: bekleyenItems),
                  _ListingTab(tabItems: gecmisItems),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model sınıfı
class ListingItem {
  final int id;
  final String fromTo;
  final String price;
  final String date;

  const ListingItem({
    required this.id,
    required this.fromTo,
    required this.price,
    required this.date,
  });
}

// Örnek veri
const List<ListingItem> aktifItems = [
  ListingItem(id: 1, fromTo: 'Nereden→Nereye', price: '16000+KDV', date: '15 Mart'),
  ListingItem(id: 2, fromTo: 'Nereden→Nereye', price: '16000+KDV', date: '15 Mart'),
  ListingItem(id: 3, fromTo: 'Nereden→Nereye', price: '16000+KDV', date: '15 Mart'),
  ListingItem(id: 4, fromTo: 'Nereden→Nereye', price: '16000+KDV', date: '15 Mart'),
  ListingItem(id: 5, fromTo: 'Nereden→Nereye', price: '16000+KDV', date: '15 Mart'),
  ListingItem(id: 6, fromTo: 'Nereden→Nereye', price: '16000+KDV', date: '15 Mart'),
];

const List<ListingItem> bekleyenItems = [];
const List<ListingItem> gecmisItems = [];

// Liste sekmesi widget’ı
class _ListingTab extends StatelessWidget {
  final List<ListingItem> tabItems;

  const _ListingTab({Key? key, required this.tabItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tabItems.isEmpty) {
      return const Center(
        child: Text(
          'Kayıt bulunamadı',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: tabItems.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final item = tabItems[index];
        return InkWell(
          onTap: () {
            // İlan detay sayfasına yönlendirme
            // main.dart içinde:
            // routes: { '/listing': (_) => ListingPage(), },
            // veya onGenerateRoute ile '/listing/:id' desenini yakalayabilirsiniz.
            Navigator.pushNamed(
              context,
              '/listing',
              arguments: item.id,
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.fromTo,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.price,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  item.date,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
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