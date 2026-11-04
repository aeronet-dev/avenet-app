import 'package:flutter/material.dart';
import 'login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(Key? key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil & Akun'),
        backgroundColor: const Color(0xFF101927),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF1E293B)),
              accountName: Text('Avenet User', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              accountEmail: Text('user@avenet.vpn', style: TextStyle(color: Colors.grey)),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.cyan,
                child: Icon(Icons.person, size: 40, color: Colors.black),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              color: const Color(0xFF1E293B),
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.wifi_lock, color: Colors.cyan),
                title: const Text('Login Hotspot / Member', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                subtitle: const Text('Masuk via Voucher, Member, atau Iuran', style: TextStyle(color: Colors.grey)),
                trailing: const Icon(Icons.chevron_right, color: Colors.white),
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
              color: const Color(0xFF1E293B),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Status Langganan:', style: TextStyle(fontSize: 14, color: Colors.grey)),
                    SizedBox(height: 5),
                    Text('Free Tier (Belum VIP)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            Card(
              color: const Color(0xFF1E293B),
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
                        const Text('AVENET8899', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
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

