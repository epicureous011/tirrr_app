import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tirrr_app/message.dart';
import 'package:tirrr_app/messages.dart';
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

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('tr_TR', null);
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
      locale: const Locale('tr', 'TR'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('tr', 'TR'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
        '/messages': (context) => const MessagesPage(),
        '/message': (context) {
          final chatId = ModalRoute.of(context)!.settings.arguments as String;
          return MessagePage(chatId: chatId);
        },
      },
    );
  }
}
