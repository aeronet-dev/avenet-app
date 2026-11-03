import 'package:flutter/material.dart';
import 'api_service.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  bool _isLoading = false;

  final List> _packages = [
    {
      'id': 'pkg_10gb',
      'title': 'Paket Hemat 10 GB',
      'quota': '10 GB / 30 Hari',
      'price': 'Rp 25.000',
    },
    {
      'id': 'pkg_50gb',
      'title': 'Paket Reguler 50 GB',
      'quota': '50 GB / 30 Hari',
      'price': 'Rp 75.000',
    },
    {
      'id': 'pkg_unlimited',
      'title': 'Paket Unlimited VIP',
      'quota': 'Unlimited / 30 Hari',
      'price': 'Rp 150.000',
    },
  ];

  void _buyPackage(String packageId, String title, String price) async {
    setState(() {
      _isLoading = true;
    });

    // Memanggil API Service untuk memproses pembelian via QRIS
    bool success = await ApiService.purchasePackage(packageId, 'QRIS');

    setState(() {
      _isLoading = false;
    });

    if (success) {
      // Tampilkan dialog QRIS Pembayaran
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          title: const Text('Scan QRIS Pembayaran', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Pembelian: $title', style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 10),
              Text('Total: $price', style: const TextStyle(color: Color(0xFF06B6D4), fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 20),
              // Kotak Simulasi QR Code
              Container(
                width: 200,
                height: 200,
                color: Colors.white,
                child: const Center(
                  child: Icon(Icons.qr_code_2, size: 150, color: Colors.black),
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Silakan scan QRIS di atas menggunakan aplikasi e-wallet atau m-banking Anda.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup', style: TextStyle(color: Color(0xFF06B6D4))),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal membuat transaksi. Silakan coba lagi.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko Paket Avenet'),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.builder(
                itemCount: _packages.length,
                itemBuilder: (context, index) {
                  final pkg = _packages[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(16),
                    ),
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
                              pkg['quota'],
                              style: const TextStyle(color: Colors.grey, fontSize: 13),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              pkg['price'],
                              style: const TextStyle(
                                color: Color(0xFF10B981),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
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
                          onPressed: () => _buyPackage(pkg['id'], pkg['title'], pkg['price']),
                          child: const Text('Beli QRIS', style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}

