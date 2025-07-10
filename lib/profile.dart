

import 'package:flutter/material.dart';
import 'components/app_header.dart';
import 'components/drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Dummy controllers with initial values
  final _phoneController = TextEditingController(text: '05316882362');
  final _passwordController = TextEditingController(text: '**********');
  final _plateController = TextEditingController(text: '42TC432');
  final _taxController = TextEditingController(text: '4534895739842');
  final _addressController = TextEditingController(text: 'Levent/İstanbul');
  final _firstNameController = TextEditingController(text: 'Sude');
  final _lastNameController = TextEditingController(text: 'Sır');
  final _birthDateController = TextEditingController(text: '23.10.2005');
  final _vehicleTypeController = TextEditingController(text: 'Panelvan/ Kamyonet');
  final _trailerTypeController = TextEditingController(text: 'Frigo/ Kapalı');
  final _floorType1Controller = TextEditingController(text: 'Tahta Taban/ Sac Taban');
  final _floorType2Controller = TextEditingController(text: 'Tahta Taban/ Sac Taban');
  final _maxLoadController = TextEditingController(text: '15 - 30');

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
                child: Text(
                  'Profil',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E2A78),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Avatar
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: Color(0xFFE5E5E5),
                      child: Icon(Icons.person, size: 48, color: Colors.white),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF1E2A78),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Icon(Icons.edit, size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Account Section
              Text(
                'Hesap Bilgileriniz',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              _buildField(label: 'Telefon Numaranız', controller: _phoneController),
              const SizedBox(height: 16),
              _buildField(
                label: 'Şifreniz',
                controller: _passwordController,
                obscureText: true,
                suffix: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgot-password');
                    },
                    child: Text('Şifreyi Değiştir'),
                    style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size(50, 30)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Divider(color: Color(0xFFBDBDBD), thickness: 1),
              const SizedBox(height: 24),
              // Work Section
              Text(
                'İş Bilgileriniz',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              _buildField(label: 'Plakanız', controller: _plateController),
              const SizedBox(height: 16),
              _buildField(label: 'Vergi Numaranız', controller: _taxController),
              const SizedBox(height: 16),
              _buildField(label: 'Adresiniz', controller: _addressController),
              const SizedBox(height: 24),
              Divider(color: Color(0xFFBDBDBD), thickness: 1),
              const SizedBox(height: 24),
              // Personal Section
              Text(
                'Kişisel Bilgileriniz',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              _buildField(label: 'İsminiz', controller: _firstNameController),
              const SizedBox(height: 16),
              _buildField(label: 'Soyisminiz', controller: _lastNameController),
              const SizedBox(height: 16),
              _buildField(label: 'Doğum Tarihiniz', controller: _birthDateController),
              const SizedBox(height: 24),
              Divider(color: Color(0xFFBDBDBD), thickness: 1),
              const SizedBox(height: 24),
              // Vehicle Section
              Text(
                'Araç Bilgileriniz',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              _buildField(label: 'Araç Tipi', controller: _vehicleTypeController),
              const SizedBox(height: 16),
              _buildField(label: 'Dorse Tipi', controller: _trailerTypeController),
              const SizedBox(height: 16),
              _buildField(label: 'Zemin Tipi', controller: _floorType1Controller),
              const SizedBox(height: 16),
              _buildField(label: 'Zemin Tipi', controller: _floorType2Controller),
              const SizedBox(height: 16),
              _buildField(label: 'Maksimum Yük Miktarı', controller: _maxLoadController),
              const SizedBox(height: 32),
              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Save profile
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF1E2A78),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Kaydet',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    Widget? suffix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            suffixIcon: suffix,
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
        ),
      ],
    );
  }
}