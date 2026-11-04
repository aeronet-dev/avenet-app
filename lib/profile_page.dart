import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isHotspotActive = false;
  final String _referralCode = 'AVENET2026';
  int _connectedDevices = 0;

  void _toggleHotspot() {
    setState(() {
      _isHotspotActive = !_isHotspotActive;
      _connectedDevices = _isHotspotActive ? 2 : 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isHotspotActive
              ? 'Hotspot Avenet diaktifkan. Perangkat lain dapat terhubung!'
              : 'Hotspot Avenet dimatikan.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101927),
      appBar: AppBar(
        title: const Text('Akun & Hotspot Avenet', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF101927),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Bagian Profil Pengguna
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.cyan.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.cyan,
                  child: Icon(Icons.person, size: 35, color: Colors.black),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Mitra Avenet',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'status: Member Aktif (VIP)',
                      style: TextStyle(fontSize: 13, color: Colors.greenAccent),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Bagian Kode Referral
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kode Referral Anda',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _referralCode,
                      style: const TextStyle(color: Colors.cyan, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Kode referral disalin ke clipboard!')),
                        );
                      },
                      icon: const Icon(Icons.copy, size: 16, color: Colors.black),
                      label: const Text('Salin', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Bagian Kontrol Hotspot / Tethering
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHotspotActive ? Colors.greenAccent.withOpacity(0.5) : Colors.cyan.withOpacity(0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.wifi_tethering, color: Colors.cyan, size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Distribusi Hotspot VPN',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Switch(
                      value: _isHotspotActive,
                      activeColor: Colors.greenAccent,
                      onChanged: (val) => _toggleHotspot(),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  _isHotspotActive
                      ? 'Status: Aktif Membagikan Koneksi Terenkripsi'
                      : 'Status: Nonaktif (Nyalakan untuk berbagi internet ke perangkat lain)',
                  style: TextStyle(color: _isHotspotActive ? Colors.greenAccent : Colors.grey, fontSize: 13),
                ),
                const SizedBox(height: 12),
                Divider(color: Colors.grey.withOpacity(0.2)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Perangkat Terhubung:',
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                    Text(
                      '$_connectedDevices Perangkat',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
