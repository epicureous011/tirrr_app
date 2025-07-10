import 'package:flutter/material.dart';
import 'components/app_header.dart';
import 'components/drawer.dart';
import 'search-listing-result.dart';

class SearchListingPage extends StatelessWidget {
  const SearchListingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(),
      drawer: AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page Title
              Center(
                child: const Text(
                  'İlan Ara',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E2A78),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Search Fields
              _buildLabel('Kalkış Noktası'),
              _buildField('Bir konum belirleyin'),
              const SizedBox(height: 16),

              _buildLabel('Ücret Aralığı'),
              _buildField('Bir fiyat aralığı seçin'),
              const SizedBox(height: 16),

              _buildLabel('Başlangıç Tarihi'),
              _buildField('Bir tarih seçin'),
              const SizedBox(height: 16),

              _buildLabel('Bitiş Tarihi'),
              _buildField('Bir tarih seçin'),
              const SizedBox(height: 16),

              _buildLabel('Maksimum Yük Ağırlığı'),
              _buildField('Bir ton seçin'),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),

      // Search Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/search-listing-result');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E2A78),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Ara',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildField(String hint) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Color(0xFF828282),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
      ),
    );
  }
}