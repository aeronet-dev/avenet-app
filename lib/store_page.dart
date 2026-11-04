import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  // Menggunakan List dinamis tanpa kurung siku tipe data agar aman dari error web editor
  final List _packages = [
    {'id': '1', 'title': 'VIP Weekly', 'quota': 'Unlimited', 'price': 'Rp 15.000'},
    {'id': '2', 'title': 'VIP Monthly', 'quota': 'Unlimited', 'price': 'Rp 45.000'},
  ];

      void _buyPackage(String id, String title, String price) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pembayaran QRIS'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Paket: $title\nTotal: $price', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              // Simulasi QR Code menggunakan ikon bawaan Flutter agar aman tanpa aset gambar
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.qr_code_2, size: 120, color: Colors.black87),
              ),
              const SizedBox(height: 10),
              const Text('Scan QRIS di atas menggunakan GoPay, OVO, Dana, atau m-Banking.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Pembayaran untuk $title berhasil dikonfirmasi!')),
                );
              },
              child: const Text('Cek Pembayaran'),
            ),
          ],
        );
      },
    );
      }
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Store')),
      body: ListView.builder(
        itemCount: _packages.length,
        itemBuilder: (context, index) {
          final pkg = _packages[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(pkg['title'].toString()),
              subtitle: Text('Kuota: ${pkg['quota']} - ${pkg['price']}'),
              trailing: ElevatedButton(
                onPressed: () => _buyPackage(
                  pkg['id'].toString(),
                  pkg['title'].toString(),
                  pkg['price'].toString(),
                ),
                child: const Text('Beli'),
              ),
            ),
          );
        },
      ),
    );
  }
}

