import 'package:flutter/material.dart';
import 'dashboard_page.dart';

void main() {
  runApp(const AvenetApp());
}

class AvenetApp extends StatelessWidget {
  const AvenetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avenet VPN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF101927),
        primarySwatch: Colors.cyan,
      ),
      home: const DashboardPage(),
    );
  }
}
