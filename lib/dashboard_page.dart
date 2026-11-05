import 'package:flutter/material.dart';
import 'api_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool isConnected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Avenet VPN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.cyanAccent),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.signal_cellular_alt, color: Colors.cyanAccent, size: 14),
                    SizedBox(width: 4),
                    Text('24 ms', style: TextStyle(color: Colors.cyanAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Status Sisa Waktu Aktif
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: ApiService.sisaWaktu > 0 ? Colors.greenAccent : Colors.redAccent,
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Masa Aktif:',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  Text(
                    ApiService.sisaWaktu > 0 
                        ? '${ApiService.sisaWaktu.toStringAsFixed(0)} Menit Aktif' 
                        : 'Habis / Belum Aktif',
                    style: TextStyle(
                      color: ApiService.sisaWaktu > 0 ? Colors.greenAccent : Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Tombol Klaim Free Trial 30 Menit
            InkWell(
              onTap: () {
                setState(() {
                  bool success = ApiService.claimFreeTrial();
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Berhasil klaim Free Trial 30 Menit!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Free Trial sudah pernah diklaim!'),
                        backgroundColor: Colors.orange,
                      ),
                    );
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  border: Border.all(color: Colors.cyan, width: 1.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.card_giftcard, color: Colors.cyan),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Klaim Free Trial 30 Menit',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Khusus Pengguna Baru (Tanpa Kuota)',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.cyan, size: 16),
                  ],
                ),
              ),
            ),
            const Spacer(),

            // Indikator Status VPN Bulat di Tengah
            Center(
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isConnected ? Colors.greenAccent : Colors.redAccent,
                    width: 4,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isConnected ? Icons.lock : Icons.lock_open,
                      size: 48,
                      color: isConnected ? Colors.greenAccent : Colors.redAccent,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isConnected ? 'TERHUBUNG' : 'OFFLINE',
                      style: TextStyle(
                        color: isConnected ? Colors.greenAccent : Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isConnected ? 'Terhubung ke Server Cepat' : 'Terputus',
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const Spacer(),

            // Tombol Hubungkan / Putuskan
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (ApiService.sisaWaktu <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Masa aktif habis! Silakan isi ulang di menu Toko atau klaim Free Trial.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    setState(() {
                      isConnected = !isConnected;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isConnected ? 'Menghubungkan ke server VPN...' : 'VPN diputus.'),
                        backgroundColor: isConnected ? Colors.green : Colors.grey,
                      ),
                    );
                  }
                },
                child: Text(
                  isConnected ? 'Putuskan Sambungan' : 'Hubungkan Sekarang',
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
