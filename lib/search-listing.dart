import 'package:flutter/material.dart';
import 'components/app_header.dart';
import 'components/drawer.dart';
import '/utils/eightyOneCities.dart';

class SearchListingPage extends StatefulWidget {
  const SearchListingPage({Key? key}) : super(key: key);

  @override
  _SearchListingPageState createState() => _SearchListingPageState();
}

class _SearchListingPageState extends State<SearchListingPage> {
  final TextEditingController kalkisController = TextEditingController();
  final TextEditingController varisController = TextEditingController();

  String? selectedKalkis;
  String? selectedVaris;

  @override
  void dispose() {
    kalkisController.dispose();
    varisController.dispose();
    super.dispose();
  }

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
              _buildDropdown(
                'Bir konum belirleyin',
                selectedValue: selectedKalkis,
                onChanged: (value) {
                  setState(() {
                    selectedKalkis = value;
                    kalkisController.text = value ?? '';
                  });
                },
              ),
              const SizedBox(height: 16),

              _buildLabel('Varış Noktası'),
              _buildDropdown(
                'Bir varış noktası belirleyin',
                selectedValue: selectedVaris,
                onChanged: (value) {
                  setState(() {
                    selectedVaris = value;
                    varisController.text = value ?? '';
                  });
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {

              Navigator.pushNamed(
                context,
                '/search-listing-result',
                arguments: {
                  'kalkis': kalkisController.text,
                  'varis': varisController.text,
                },
              );
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

  Widget _buildField(String hint, {TextEditingController? controller}) {
    return TextFormField(
      controller: controller,
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

  Widget _buildDropdown(
    String hint, {
    String? selectedValue,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.grey.shade200,
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
      items: provinces.asMap().entries.map((entry) {
        final idx = entry.key;
        final city = entry.value;
        return DropdownMenuItem<String>(
          value: city,
          child: Text(
            idx == 0 ? 'Şehir Seçin' : city,
            style: idx == 0
                ? const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  )
                : null,
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}