import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isConnected = false;
  double _remainingQuota = 2.00; // Sisa kuota dalam GB

  void _toggleConnection() {
    setState(() {
      _isConnected = !_isConnected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avenet VPN Tunnel'),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Status Kotak Informasi Kuota
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text('Sisa Kuota', style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 8),
                      Text(
                        '${_remainingQuota.toStringAsFixed(2)} GB',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF06B6D4)),
                      ),
                    ],
                  ),
                  const ContainerDivider(),
                  Column(
                    children: [
                      const Text('Status Jaringan', style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 8),
                      Text(
                        _isConnected ? 'Terhubung (Avenet)' : 'Terputus',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _isConnected ? Colors.greenAccent : Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),

            // Tombol Utama VPN Raksasa
            GestureDetector(
              onTap: _toggleConnection,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isConnected ? Colors.green.withOpacity(0.2) : const Color(0xFF06B6D4).withOpacity(0.2),
                  border: Border.all(
                    color: _isConnected ? Colors.greenAccent : const Color(0xFF06B6D4),
                    width: 4,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isConnected ? Colors.green : const Color(0xFF06B6D4),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isConnected ? Icons.power_settings_new : Icons.shield,
                          size: 50,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _isConnected ? 'PUTUSKAN' : 'HUBUNGKAN',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              _isConnected ? 'Jaringan Anda aman dan di-masking oleh Avenet' : 'Ketuk tombol di atas untuk mulai terhubung',
              style: const TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerDivider extends StatelessWidget {
  const ContainerDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey.withOpacity(0.3),
    );
  }
}
