import 'package:flutter/material.dart';
import 'components/app_header.dart';
import 'components/drawer.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppHeader(),
      drawer: AppDrawer(),
      body: SafeArea(
        child: Center(
          child: const Text(
            'Ana Sayfa',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}