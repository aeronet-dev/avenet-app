import 'package:flutter/material.dart';
import 'api_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future> _userProfileFuture;

  @override
  void initState() {
    super.initState();
    // Memanggil API service untuk mengambil data profil pengguna (ID dummy: 'user_001')
    _userProfileFuture = ApiService.fetchUserProfile('user_001');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil & Referal Avenet'),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
      ),
      body: FutureBuilder>(
        future: _userProfileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Terjadi kesalahan: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white)),
            );
          }

          final data = snapshot.data ?? {};
          final username = data['username'] ?? 'AvenetUser';
          final quotaGb = data['quota_gb'] ?? 0.0;
          final expiredDate = data['expired_date'] ?? '-';
          final referralCode = data['referral_code'] ?? 'AVENET00';
          final referralEarnings = data['referral_earnings'] ?? 0;

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                // Kartu Informasi Akun
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Color(0xFF06B6D4),
                        child: Icon(Icons.person, size: 40, color: Colors.white),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        username,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Status: Premium Member',
                        style: TextStyle(color: Color(0xFF10B981), fontSize: 13),
                      ),
                      const Divider(height: 30, color: Colors.grey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildInfoColumn('Sisa Kuota', '$quotaGb GB'),
                          _buildInfoColumn('Maktif Aktif', expiredDate),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Kartu Sistem Referal
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Program Referal Avenet',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Bagikan kode referal Anda dan dapatkan komisi saldo setiap kali teman Anda bergabung.',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0F172A),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFF06B6D4)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              referralCode,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF06B6D4),
                                letterSpacing: 1.5,
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF06B6D4),
                              ),
                              onPressed: () {
                                // Aksi salin kode referal
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Kode referal disalin!')),
                                );
                              },
                              child: const Text('Salin', style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Total Komisi: Rp $referralEarnings',
                        style: const TextStyle(
                          color: Color(0xFF10B981),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
      ],
    );
  }
}

