import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isConnected = false;
  bool _isConnecting = false;
  String _statusText = 'Terputus';

  void _toggleConnection() {
    setState(() {
      if (_isConnected) {
        // Jika sedang terhubung, putuskan koneksi
        _isConnected = false;
        _isConnecting = false;
        _statusText = 'Terputus';
      } else {
        // Proses simulasi menghubungkan ke server Xray/V2Ray
        _isConnecting = true;
        _statusText = 'Menghubungkan ke Server...';

        // Simulasi jeda waktu koneksi (2 detik)
        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            _isConnecting = false;
            _isConnected = true;
            _statusText = 'Terhubung (Avenet SG-01)';
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avenet VPN Dashboard'),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Status Indikator Lingkaran
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1E293B),
                border: Border.all(
                  color: _isConnected
                      ? const Color(0xFF10B981) // Hijau jika terhubung
                      : (_isConnecting ? Colors.amber : const Color(0xFF06B6D4)),
                  width: 4,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isConnected ? Icons.lock : Icons.lock_open,
                      size: 50,
                      color: _isConnected ? const Color(0xFF10B981) : Colors.grey,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isConnected ? 'SECURE' : 'OFFLINE',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _isConnected ? const Color(0xFF10B981) : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Keterangan Status Teks
            Text(
              _statusText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Protokol: Xray / VLESS - TLS',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 50),

            // Tombol Power Utama (Hubungkan / Putuskan)
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isConnected ? Colors.redAccent : const Color(0xFF06B6D4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _isConnecting ? null : _toggleConnection,
                child: Text(
                  _isConnecting
                      ? 'Menghubungkan...'
                      : (_isConnected ? 'Putuskan Koneksi' : 'Hubungkan Sekarang'),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

