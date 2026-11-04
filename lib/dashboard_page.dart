import 'dart:async';
import 'package:flutter/material.dart';
import 'store_page.dart';
import 'profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DashboardHomeTab(),
    StorePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101927),
      appBar: AppBar(
        title: const Text('Avenet VPN Dashboard', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF101927),
        elevation: 0,
      ),
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
          BottomNavigationBarItem(icon: Icon(Icons.shield), label: 'VPN'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Toko'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
      ),
    );
  }
}

class DashboardHomeTab extends StatefulWidget {
  const DashboardHomeTab({super.key});

  @override
  State<DashboardHomeTab> createState() => _DashboardHomeTabState();
}

class _DashboardHomeTabState extends State<DashboardHomeTab> {
  bool _isConnected = false;
  String _statusText = 'Terputus';
  int _secondsConnected = 0;
  Timer? _timer;
  double _sisaKuota = 0.0;
  bool _isFreeTrialClaimed = false;

  void _startConnectionStats() {
    _secondsConnected = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _secondsConnected++;
      });
    });
  }

  void _stopConnectionStats() {
    _timer?.cancel();
    _secondsConnected = 0;
  }

  String _formatDuration(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  void _claimFreeTrial() {
    setState(() {
      _isFreeTrialClaimed = true;
      _sisaKuota += 0.05; // Tambah 50 MB
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Berhasil klaim Free Trial 50MB!')),
    );
  }

  void _toggleConnection() {
    if (_sisaKuota <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kuota habis! Silakan isi ulang di menu Toko atau klaim Free Trial.')),
      );
      return;
    }

    setState(() {
      _isConnected = !_isConnected;
      if (_isConnected) {
        _statusText = 'Terhubung (Protokol: Xray / VLESS - TLS)';
        _startConnectionStats();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Koneksi VPN berhasil diaktifkan!')),
        );
      } else {
        _statusText = 'Terputus';
        _stopConnectionStats();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Koneksi VPN diputus.')),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Kotak Sisa Kuota
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.cyan.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Sisa Kuota:', style: TextStyle(color: Colors.grey, fontSize: 14)),
                Text(
                  '${_sisaKuota.toStringAsFixed(2)} GB (${_sisaKuota > 0 ? "Aktif" : "Habis"})',
                  style: TextStyle(
                    color: _sisaKuota > 0 ? Colors.greenAccent : Colors.redAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),

          // Tombol Klaim Free Trial
          if (!_isFreeTrialClaimed)
            InkWell(
              onTap: _claimFreeTrial,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.cyan),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.card_giftcard, color: Colors.cyan, size: 24),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Klaim Free Trial 50MB (Khusus Pengguna Baru)',
                        style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.cyan, size: 16),
                  ],
                ),
              ),
            ),
          if (!_isFreeTrialClaimed) const SizedBox(height: 25),

          // Tombol Bulat Utama (The Big Button)
          GestureDetector(
            onTap: _toggleConnection,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isConnected ? Colors.greenAccent : Colors.redAccent,
                  width: 4,
                ),
                color: const Color(0xFF1E293B),
                boxShadow: [
                  BoxShadow(
                    color: (_isConnected ? Colors.greenAccent : Colors.redAccent).withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isConnected ? Icons.lock : Icons.lock_open,
                    size: 50,
                    color: _isConnected ? Colors.greenAccent : Colors.redAccent,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _isConnected ? 'ONLINE' : 'OFFLINE',
                    style: TextStyle(
                      color: _isConnected ? Colors.greenAccent : Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          Text(
            _statusText,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),

          // WIDGET SPEEDOMETER & DURASI (Hanya tampil saat ONLINE)
          if (_isConnected) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.greenAccent.withOpacity(0.4)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.timer, color: Colors.greenAccent, size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Durasi: ${_formatDuration(_secondsConnected)}',
                        style: const TextStyle(color: Colors.greenAccent, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Row(
                        children: [
                          Icon(Icons.download, color: Colors.cyan, size: 20),
                          SizedBox(width: 6),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Download', style: TextStyle(color: Colors.grey, fontSize: 12)),
                              Text('2.3 MB/s', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.upload, color: Colors.orangeAccent, size: 20),
                          SizedBox(width: 6),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Upload', style: TextStyle(color: Colors.grey, fontSize: 12)),
                              Text('400 KB/s', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Tombol Hubungkan / Putuskan di Bawah
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isConnected ? Colors.redAccent : Colors.cyan,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _toggleConnection,
              child: Text(
                _isConnected ? 'Putuskan Koneksi' : 'Hubungkan Sekarang',
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
