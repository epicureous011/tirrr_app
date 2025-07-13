import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  bool _passwordVisible = false;
  bool _confirmVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _confirmVisible = false;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _onSignupPressed() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Create user with Firebase Authentication and Firestore profile
        UserCredential cred = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: _phoneController.text.trim(),
              password: _passwordController.text,
            );
        final uid = cred.user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'phoneNumber': '',
          'city': '',
          'plate': '',
          'firstName': '',
          'secondName': '',
          'vehicleType': '',
          'backOfVehicleType': '',
          'vehicleBaseType': '',
          'maxWeight': '',
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Hesap başarıyla oluşturuldu!')),
        );
        // Navigate to home screen after successful signup
        Navigator.pushReplacementNamed(context, '/');
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.message ?? 'Bir hata oluştu')));
      }
    }
  }

  void _onLoginTap() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _onPrivacyTap() {
    // TODO: Open privacy policy link
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Hesap Oluşturun',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 60),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'E-posta Adresiniz',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'E-posta adresinizi girin';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        hintText: 'Şifreniz',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () => setState(() {
                            _passwordVisible = !_passwordVisible;
                          }),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Şifrenizi girin';
                        }
                        if (value.length < 6) {
                          return 'En az 6 karakter olmalı';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _confirmController,
                      obscureText: !_confirmVisible,
                      decoration: InputDecoration(
                        hintText: 'Şifreniz (tekrar)',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _confirmVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () => setState(() {
                            _confirmVisible = !_confirmVisible;
                          }),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Tekrar şifrenizi girin';
                        }
                        if (value != _passwordController.text) {
                          return 'Şifreler eşleşmiyor';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        text: 'Gizlilik Sözleşmemizi okumak için ',
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: [
                          TextSpan(
                            text: 'buraya',
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color(0xFF1E2A78),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = _onPrivacyTap,
                          ),
                          const TextSpan(text: ' tıklayabilirsiniz.'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _onSignupPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E2A78),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Hesap Oluştur',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('- ya da -', style: TextStyle(fontSize: 16)),
                        TextButton(
                          onPressed: _onLoginTap,
                          child: const Text(
                            'Giriş Yap',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
