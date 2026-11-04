import 'package:flutter/material.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil & Referal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Avenet User', style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Text('user@avenet.vpn'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Icon(Icons.person, size: 40, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.wifi_lock, color: Colors.cyan),
                title: const Text('Login Hotspot / Member', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: const Text('Login akun voucher atau iuran jaringan'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Status Langganan:', style: TextStyle(fontSize: 14, color: Colors.grey)),
                    const SizedBox(height: 5),
                    const Text('Free Tier (Belum VIP)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Kode Referal Anda:', style: TextStyle(fontSize: 14, color: Colors.grey)),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('AVENET8899', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Kode referal berhasil disalin!')),
                            );
                          },
                          icon: const Icon(Icons.copy, size: 16),
                          label: const Text('Salin'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

