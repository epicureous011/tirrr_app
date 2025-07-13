import 'package:flutter/material.dart';
import 'components/app_header.dart';
import 'components/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Dummy controllers with initial values
  final _phoneController = TextEditingController();
  final _plateController = TextEditingController();
  final _addressController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _vehicleTypeController = TextEditingController();
  final _trailerTypeController = TextEditingController();
  final _floorType1Controller = TextEditingController();
  final _maxLoadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .get();
    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();
      setState(() {
        _phoneController.text       = data['phoneNumber'] as String? ?? '';
        _addressController.text     = data['city']        as String? ?? '';
        _plateController.text       = data['plate']       as String? ?? '';
        _firstNameController.text   = data['firstName']   as String? ?? '';
        _lastNameController.text    = data['secondName']  as String? ?? '';
        _birthDateController.text   = data['birthDate']   as String? ?? '';
        _vehicleTypeController.text = data['vehicleType'] as String? ?? '';
        _trailerTypeController.text = data['backOfVehicleType'] as String? ?? '';
        _floorType1Controller.text  = data['vehicleBaseType']   as String? ?? '';
        _maxLoadController.text     = data['maxWeight'] as String? ?? '';
      });
    } else {
      print('No documents found in users collection');
    }
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
              _buildField(label: 'İliniz', controller: _addressController),
              const SizedBox(height: 24),
//            Divider(color: Color(0xFFBDBDBD), thickness: 1),
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
              const SizedBox(height: 24),
//            Divider(color: Color(0xFFBDBDBD), thickness: 1),
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
              _buildField(label: 'Maksimum Yük Miktarı', controller: _maxLoadController),
              const SizedBox(height: 32),
              // Save Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    final collection = FirebaseFirestore.instance.collection('users');
                    try {
                      final snapshot = await collection.get();
                      if (snapshot.docs.isNotEmpty) {
                        final docId = snapshot.docs.first.id;
                        await collection.doc(docId).set({
                          'phoneNumber': _phoneController.text,
                          'city':        _addressController.text,
                          'plate':       _plateController.text,
                          'firstName':   _firstNameController.text,
                          'secondName':  _lastNameController.text,
                          'vehicleType': _vehicleTypeController.text,
                          'backOfVehicleType': _trailerTypeController.text,
                          'vehicleBaseType':   _floorType1Controller.text,
                          'maxWeight':  _maxLoadController.text,
                        }, SetOptions(merge: true));
                      } else {
                        await collection.add({
                          'phoneNumber': _phoneController.text,
                          'city':        _addressController.text,
                          'plate':       _plateController.text,
                          'firstName':   _firstNameController.text,
                          'secondName':  _lastNameController.text,
                          'birthDate':   _birthDateController.text,
                          'vehicleType': _vehicleTypeController.text,
                          'backOfVehicleType': _trailerTypeController.text,
                          'vehicleBaseType':   _floorType1Controller.text,
                          'maxWeight':  _maxLoadController.text,
                        });
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Profil başarıyla kaydedildi.')),
                      );
                    } catch (e) {
                      print('Error saving profile: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Profil kaydedilirken hata oluştu.')),
                      );
                    }
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