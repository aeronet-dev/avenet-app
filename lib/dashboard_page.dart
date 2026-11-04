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

  // Variabel Kuota & Free Trial
  double _sisaKuotaGB = 0.0; 
  bool _isMasaAktifValid = false;
  bool _hasClaimedTrial = false; 

  // Variabel Server Terpilih
  String _selectedServer = 'Server Utama (Indonesia - RT/RW Net)';
  final List<String> _serverList = [
    'Server Utama (Indonesia - RT/RW Net)',
    'Server VIP 1 (Singapura - SGX)',
    'Server VIP 2 (Jepang - TYO)',
    'Server VIP 3 (Amerika Serikat - US)',
  ];

  // Fungsi Pilih Server Dialog
  void _showServerSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Pilih Lokasi Server', style: TextStyle(color: Colors.white)),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _serverList.length,
            itemBuilder: (context, index) {
              final server = _serverList[index];
              return ListTile(
                title: Text(server, style: const TextStyle(color: Colors.white, fontSize: 14)),
                leading: const Icon(Icons.dns, color: Colors.cyan),
                onTap: () {
                  setState(() {
                    _selectedServer = server;
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Server diubah ke: $server')),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  // Fungsi Klaim Free Trial
  void _klaimFreeTrial() {
    setState(() {
      _hasClaimedTrial = true;
      _sisaKuotaGB = 0.05; // 50 MB Free Trial
      _isMasaAktifValid = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Selamat! Kuota Free Trial 50 MB berhasil diklaim.')),
    );
  }

  Future<void> _toggleVpnConnection() async {
    if (_sisaKuotaGB <= 0 || !_isMasaAktifValid) {
      _tunjukkanDialogBeliPaket();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    if (!_isConnected) {
      bool success = await VpnServiceManager.connect();
      setState(() {
        _isConnected = success;
        _statusText = success ? 'Terhubung ($_selectedServer)' : 'Terputus';
      });
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('VPN Berhasil Terhubung!')),
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

  void _tunjukkanDialogBeliPaket() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Akses Dibatasi', style: TextStyle(color: Colors.white)),
        content: const Text(
          'Maaf, sisa kuota Anda habis. Silakan klaim Free Trial di bawah atau beli paket internet di menu Toko.',
          style: TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup', style: TextStyle(color: Colors.cyan)),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Tombol Pilihan Server
            GestureDetector(
              onTap: _isConnected ? null : _showServerSelectionDialog,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.cyan.withOpacity(0.4)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.public, color: Colors.cyan),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Lokasi Server', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            const SizedBox(height: 2),
                            Text(
                              _selectedServer,
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Informasi Sisa Kuota
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
                    _sisaKuotaGB > 0 ? '$_sisaKuotaGB GB (Aktif)' : '0 GB (Habis)',
                    style: TextStyle(
                      color: _sisaKuotaGB > 0 ? Colors.greenAccent : Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            // Tombol Klaim Free Trial
            if (!_hasClaimedTrial) ...[
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.cyan, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _klaimFreeTrial,
                  icon: const Icon(Icons.card_giftcard, color: Colors.cyan, size: 20),
                  label: const Text(
                    'Klaim Free Trial 50MB (Pengguna Baru)',
                    style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ),
            ],
            
            const SizedBox(height: 30),

            // Tombol Bulat Utama (The Big Button)
            Container(
              width: 160,
              height: 160,
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
                    size: 45,
                    color: _isConnected ? Colors.greenAccent : Colors.redAccent,
                  ),
                  const SizedBox(height: 8),
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
            const SizedBox(height: 25),
            Text(
              _statusText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 35),
            
            // Tombol Hubungkan / Putuskan
            SizedBox(
              width: double.infinity,
              height: 52,
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
    );
  }
}

