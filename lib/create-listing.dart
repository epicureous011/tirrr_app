import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'components/app_header.dart';
import 'components/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateListingPage extends StatefulWidget {
  const CreateListingPage({Key? key}) : super(key: key);

  @override
  _CreateListingPageState createState() => _CreateListingPageState();
}

class _CreateListingPageState extends State<CreateListingPage> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _volumeController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

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
              _buildField('Bir konum belirleyin', _originController),
              const SizedBox(height: 16),

              _buildLabel('Varış Noktası'),
              _buildField('Bir konum belirleyin', _destinationController),
              const SizedBox(height: 16),

              _buildLabel('Ağırlık(Ton)'),
              _buildField('Bir ağırlık yazın', _weightController),
              const SizedBox(height: 16),

              _buildLabel('Hacim(m³)'),
              _buildField('Bir hacim belirleyin', _volumeController),
              const SizedBox(height: 16),

              _buildLabel('İçerik'),
              _buildField('Bir içerik seçin', _contentController),
              const SizedBox(height: 16),

              _buildLabel('Kalkış Tarihi Başlangıç'),
              TextFormField(
                controller: _startDateController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Başlangıç tarihini seçin',
                  hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.black, width: 2)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    locale: const Locale('tr', 'TR'),
                  );
                  if (picked != null) {
                    _startDateController.text = DateFormat('dd MMMM yyyy', 'tr_TR').format(picked);
                  }
                },
              ),
              const SizedBox(height: 16),

              _buildLabel('Kalkış Tarihi Bitiş'),
              TextFormField(
                controller: _endDateController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Bitiş tarihini seçin',
                  hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.black, width: 2)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    locale: const Locale('tr', 'TR'),
                  );
                  if (picked != null) {
                    _endDateController.text = DateFormat('dd MMMM yyyy', 'tr_TR').format(picked);
                  }
                },
              ),
              const SizedBox(height: 16),

              _buildLabel('Ücret (KDV Hariç)'),
              _buildField('Bir ücret girin', _priceController),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      await FirebaseFirestore.instance.collection('posts').add({
                        'origin': _originController.text,
                        'destination': _destinationController.text,
                        'weight': _weightController.text,
                        'volume': _volumeController.text,
                        'content': _contentController.text,
                        'price': _priceController.text,
                        'startDate': _startDateController.text,
                        'endDate': _endDateController.text,
                        'uid': user.uid,
                      });
                      // Clear all form fields
                      _originController.clear();
                      _destinationController.clear();
                      _weightController.clear();
                      _volumeController.clear();
                      _contentController.clear();
                      _priceController.clear();
                      _startDateController.clear();
                      _endDateController.clear();

                      // Show success alert
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: const Text('Başarılı bir şekilde paylaşıldı!'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Tamam'),
                            ),
                          ],
                        ),
                      );
                      // TODO: handle post submission success (e.g., navigate back or show a message)
                    }
                    // TODO: handle user not logged in case
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E2A78),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Yayınla',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
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

  Widget _buildField(String hint, TextEditingController controller) {
    return TextFormField(
      controller: controller,
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

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _originController.dispose();
    _destinationController.dispose();
    _weightController.dispose();
    _volumeController.dispose();
    _contentController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}