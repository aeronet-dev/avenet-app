import 'package:flutter/material.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  // Data pilihan paket kuota Avenet
  final List> _packages = const [
    {
      'title': 'Paket Harian (1 GB)',
      'quota': '1 GB',
      'duration': '1 Hari',
      'price': 'Rp 3.000',
    },
    {
      'title': 'Paket Hemat (5 GB)',
      'quota': '5 GB',
      'duration': '7 Hari',
      'price': 'Rp 12.000',
    },
    {
      'title': 'Paket Bulanan (20 GB)',
      'quota': '20 GB',
      'duration': '30 Hari',
      'price': 'Rp 45.000',
    },
  ];

  void _showQrisDialog(BuildContext context, String title, String price) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: Text('Bayar $title', style: const TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Silakan scan QRIS di bawah ini menggunakan aplikasi m-Banking atau E-Wallet Anda:',
                style: TextStyle(color: Colors.grey, fontSize: 13),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Simulasi Kotak QRIS Dinamis
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Icon(
                    Icons.qr_code_2,
                    size: 150,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Total: $price',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF06B6D4),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Kuota otomatis bertambah setelah pembayaran sukses.',
                style: TextStyle(color: Colors.greenAccent, fontSize: 11),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tutup', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF06B6D4)),
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Simulasi: Pembayaran Berhasil! Kuota ditambahkan.')),
                );
              },
              child: const Text('Simulasi Bayar Sukses', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko Paket Avenet'),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _packages.length,
        itemBuilder: (context, index) {
          final pkg = _packages[index];
          return Card(
            color: const Color(0xFF1E293B),
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pkg['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Masa Aktif: ${pkg['duration']}',
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        pkg['price'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF06B6D4),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF06B6D4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () => _showQrisDialog(context, pkg['title'], pkg['price']),
                    child: const Text('Beli QRIS', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
