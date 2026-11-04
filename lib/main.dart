import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'store_page.dart';
import 'profile_page.dart';
import 'login_page.dart';

void main() {
  runApp(const AvenetApp());
}

class AvenetApp extends StatelessWidget {
  const AvenetApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avenet App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.cyan,
        scaffoldBackgroundColor: const Color(0xFF101927),
      ),
      // Kita mulai dari halaman Login/Masuk sesuai rencana nomor 1
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const MainNavigator(),
      },
    );
  }
}

class MainNavigator extends StatefulWidget {
  const MainNavigator({Key? key}) : super(key: key);

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;

  // Urutan Halaman sesuai Rencana:
  // 0: Dashboard/Koneksi (Connection Screen)
  // 1: Toko Paket (Store Screen)
  // 2: Profil & Akun / Pengaturan
  final List<Widget> _pages = [
    const DashboardPage(),
    const StorePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF1E293B),
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shield),
            label: 'VPN / Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Toko Paket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun & Login',
          ),
        ],
      ),
    );
  }
}

