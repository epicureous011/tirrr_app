import 'package:flutter/material.dart';
import 'components/app_header.dart';
import 'components/drawer.dart';

class CreateListingPage extends StatelessWidget {
  const CreateListingPage({Key? key}) : super(key: key);

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
              const Text(
                'İlan Ver',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E2A78),
                ),
              ),
              const SizedBox(height: 24),

              // Form Fields
              _buildLabel('Kalkış Noktası'),
              _buildField('Bir konum belirleyin'),
              const SizedBox(height: 16),

              _buildLabel('Varış Noktası'),
              _buildField('Bir konum belirleyin'),
              const SizedBox(height: 16),

              _buildLabel('Ağırlık'),
              _buildField('Bir ağırlık yazın'),
              const SizedBox(height: 16),

              _buildLabel('Hacim'),
              _buildField('Bir hacim belirleyin'),
              const SizedBox(height: 16),

              _buildLabel('İçerik'),
              _buildField('Bir içerik seçin'),
              const SizedBox(height: 16),

              _buildLabel('Kalkış Tarih Aralığı'),
              _buildField('Bir tarih aralığı seçin'),
              const SizedBox(height: 16),

              _buildLabel('Ücret (KDV Hariç)'),
              _buildField('Bir ücret girin'),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),

      // Publish Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Submit form
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E2A78),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Publish',
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
          color: Colors.black,
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