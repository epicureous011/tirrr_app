import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'forgot_password.dart';
import 'homepage.dart';
import 'settings.dart';
import 'listing.dart';
import 'create-listing.dart';
import 'search-listing.dart';
import 'search-listing-result.dart';
import 'profile.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logistics App',
      theme: ThemeData(
        primaryColor: const Color(0xFF1E2A78),
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data != null) {
            return const HomePage();
          }
          return const LoginScreen();
        },
      ),
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/settings': (context) => const SettingsPage(),
        '/listing': (context) => const ListingPage(),
        '/post-listing': (context) => const CreateListingPage(),
        '/search-listing': (context) => const SearchListingPage(),
        '/search-listing-result': (context) => const SearchListingResultPage(),
        '/profile': (context) => const ProfilePage(),

      },
    );
  }
}

