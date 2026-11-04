import 'package:flutter/material.dart';
import 'vpn_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isConnected = false;
  bool _isLoading = false;
  String _statusText = 'Terputus';

  // Simulasi data kuota & masa aktif pengguna (Nanti diambil dari database server)
  final double _sisaKuotaGB = 0.0; // Saat ini 0 (belum beli paket)
  final bool _isMasaAktifValid = false; // Belum aktif

  Future<void> _toggleVpnConnection() async {
    // 1. PENGECEKAN GATEKEEPING (Validasi Kuota & Masa Aktif Nyata)
    if (_sisaKuotaGB <= 0 || !_isMasaAktifValid) {
      _tunjukkanDialogBeliPaket();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulasi proses koneksi jaringan
    await Future.delayed(const Duration(seconds: 1));

    if (!_isConnected) {
      bool success = await VpnServiceManager.connect();
      setState(() {
        _isConnected = success;
        _statusText = success ? 'Terhubung (Xray/VLESS)' : 'Terputus';
      });
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('VPN Berhasil Terhubung ke Server Avenet!')),
        );
      }
    } else {
      bool success = await VpnServiceManager.disconnect();
      setState(() {
        _isConnected = success;
        _statusText = 'Terputus';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Koneksi VPN diputus.')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Peringatan jika kuota habis / belum beli paket
  void _tunjukkanDialogBeliPaket() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Akses Dibatasi', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Maaf, sisa kuota Anda habis atau masa aktif telah berakhir. Silakan beli paket internet terlebih dahulu di menu Toko.',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup', style: TextStyle(color: Colors.cyan)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
            onPressed: () {
              Navigator.pop(context);
              // Pindah otomatis ke Tab Toko (Index 1) di bawah
            },
            child: const Text('Beli Paket Sekarang', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101927),
      appBar: AppBar(
        title: const Text('Avenet VPN Dashboard', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF101927),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Informasi Sisa Kuota di Atas Tombol Utama
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Sisa Kuota:', style: TextStyle(color: Colors.grey)),
                    Text(
                      '$_sisaKuotaGB GB (Habis)',
                      style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Tombol Bulat Utama (The Big Button)
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _isConnected ? Colors.greenAccent : Colors.redAccent,
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (_isConnected ? Colors.greenAccent : Colors.redAccent).withOpacity(0.2),
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
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Text(
                _statusText,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Protokol: Xray / VLESS - TLS',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 40),
              
              // Tombol Hubungkan / Putuskan
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isConnected ? Colors.redAccent : Colors.cyan,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: _isLoading ? null : _toggleVpnConnection,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          _isConnected ? 'Putuskan Koneksi' : 'Hubungkan Sekarang',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

