import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  // Versi aman tanpa simbol tipe data kompleks agar tidak error di GitHub
  final packages = [
    {
      'id': 'v_2h',
      'title': 'Voucher Kilat 2 Jam',
      'duration': '2 Jam',
      'speed': '3 Mbps',
      'price': 'Rp 1.000',
      'isPopular': false,
      'features': ['Unlimited Data (Tanpa Kuota)', 'Kecepatan Stabil (3 Mbps)', 'Aktif 2 Jam penuh'],
    },
    {
      'id': 'v_7h',
      'title': 'Voucher Hemat 7 Jam',
      'duration': '7 Jam',
      'speed': '5 Mbps',
      'price': 'Rp 2.000',
      'isPopular': true,
      'features': ['Unlimited Data (Tanpa Kuota)', 'Kecepatan Ngebut (5 Mbps)', 'Aktif 7 Jam penuh'],
    },
    {
      'id': 'v_24h',
      'title': 'Voucher Harian (24 Jam)',
      'duration': '24 Jam (1 Hari)',
      'speed': '5 Mbps',
      'price': 'Rp 5.000',
      'isPopular': false,
      'features': ['Unlimited Data (Tanpa Kuota)', 'Kecepatan Stabil (5 Mbps)', 'Aktif 24 Jam penuh'],
    },
    {
      'id': 'v_7d',
      'title': 'Voucher Mingguan',
      'duration': '7 Hari',
      'speed': '8 Mbps',
      'price': 'Rp 25.000',
      'isPopular': false,
      'features': ['Unlimited Data (Tanpa Kuota)', 'Kecepatan Tinggi (8 Mbps)', 'Aktif 7 Hari penuh'],
    },
    {
      'id': 'v_30d',
      'title': 'Voucher Bulanan VIP',
      'duration': '30 Hari',
      'speed': '10 Mbps (Full Speed)',
      'price': 'Rp 75.000',
      'isPopular': false,
      'features': ['Unlimited Data (Tanpa Kuota)', 'Kecepatan Prioritas (10 Mbps)', 'Aktif 30 Hari penuh'],
    },
  ];

  void _showPurchaseDialog(BuildContext context, Map<String, dynamic> package) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Konfirmasi Pembelian', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Paket: ${package['title']}'),
              const SizedBox(height: 6),
              Text('Durasi: ${package['duration']}'),
              Text('Kecepatan: ${package['speed']}'),
              const SizedBox(height: 6),
              Text('Total Bayar: ${package['price']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
              const SizedBox(height: 16),
              const Text('Metode: QRIS Otomatis', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Membuat QRIS pembayaran untuk ${package['title']}...'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Lanjut Bayar', style: TextStyle(color: Colors.white)),
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
        title: const Text('Toko Voucher Internet'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: packages.length,
        itemBuilder: (context, index) {
          final item = packages[index];
          final isPopular = item['isPopular'] as bool;

          return Card(
            elevation: isPopular ? 4 : 2,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: isPopular
                  ? const BorderSide(color: Colors.blue, width: 2)
                  : BorderSide.none,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isPopular)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'PALING POPULER',
                        style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['title'] as String,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        item['price'] as String,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text('Durasi: ${item['duration']}', style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 16),
                      const Icon(Icons.speed, size: 16, color: Colors.blue),
                      const SizedBox(width: 4),
                      Text('Speed: ${item['speed']}', style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Divider(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: (item['features'] as List).map((feat) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_outline, size: 16, color: Colors.green),
                            const SizedBox(width: 8),
                            Text(feat.toString(), style: const TextStyle(fontSize: 13)),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () => _showPurchaseDialog(context, item),
                      child: const Text('Beli Voucher Sekarang', style: TextStyle(color: Colors.white)),
                    ),
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
