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
    // Menampilkan dialog pop-up saat tombol Beli ditekan
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Pembelian'),
          content: Text('Apakah Anda ingin membeli paket $title seharga $price?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Berhasil memilih paket $title!')),
                );
              },
              child: Text('Beli Sekarang'),
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

