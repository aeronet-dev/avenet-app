import 'package:flutter/material.dart';
import 'vpn_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isConnected = false;
  bool _isLoading = false;
  String _statusText = 'Terputus';

  Future<void> _toggleVpnConnection() async {
    setState(() {
      _isLoading = true;
    });

    // Jeda simulasi proses koneksi jaringan
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
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _isConnected ? Colors.greenAccent : Colors.cyan,
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (_isConnected ? Colors.greenAccent : Colors.cyan).withOpacity(0.2),
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
                      size: 60,
                      color: _isConnected ? Colors.greenAccent : Colors.cyan,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _isConnected ? 'ONLINE' : 'OFFLINE',
                      style: TextStyle(
                        color: _isConnected ? Colors.greenAccent : Colors.cyan,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
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
              const SizedBox(height: 50),
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

