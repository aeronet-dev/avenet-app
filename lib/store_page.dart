import 'package:flutter/material.dart';
import 'api_service.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final TextEditingController _voucherController = TextEditingController();

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
      'speed': '10 Mbps',
      'price': 'Rp 75.000',
      'isPopular': false,
      'features': ['Unlimited Data (Tanpa Kuota)', 'Kecepatan Prioritas (10 Mbps)', 'Aktif 30 Hari penuh'],
    },
  ];

  void _processRedeem() {
    String code = _voucherController.text;
    if (code.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan kode voucher terlebih dahulu!'), backgroundColor: Colors.orange),
      );
      return;
    }

    bool success = ApiService.redeemVoucherCode(code);
    setState(() {
      _voucherController.clear();
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Berhasil! Masa aktif VPN Anda bertambah.'), backgroundColor: Colors.green),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kode voucher salah atau sudah tidak berlaku!'), backgroundColor: Colors.red),
      );
    }
  }

  void _showPurchaseDialog(BuildContext context, Map<String, dynamic> package) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Konfirmasi Pembelian', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Paket: ${package['title']}', style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 6),
              Text('Durasi: ${package['duration']}', style: const TextStyle(color: Colors.white70)),
              Text('Kecepatan: ${package['speed']}', style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 6),
              Text('Total Bayar: ${package['price']}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan)),
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
                backgroundColor: Colors.cyan,
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
              child: const Text('Lanjut Bayar', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Toko Voucher Internet', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Kotak Input Redeem Voucher Manual
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.cyan, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Punya Kode Voucher Fisik?',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Masukkan kode voucher di bawah untuk langsung menambah masa aktif.',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _voucherController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Contoh: AVENET2H',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFF0F172A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: _processRedeem,
                    child: const Text(
                      'Gunakan Voucher',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Daftar Paket Berlangganan',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          
          // List Paket Voucher
          ...packages.map((item) {
            final isPopular = item['isPopular'] as bool;

            return Card(
              color: const Color(0xFF1E293B),
              elevation: isPopular ? 4 : 2,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: isPopular
                    ? const BorderSide(color: Colors.cyan, width: 2)
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
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'PALING POPULER',
                          style: TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item['title'].toString(),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item['price'].toString(),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.cyan),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 12,
                      runSpacing: 4,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.access_time, size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text('Durasi: ${item['duration']}', style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.speed, size: 14, color: Colors.cyan),
                            const SizedBox(width: 4),
                            Text('Speed: ${item['speed']}', style: const TextStyle(color: Colors.cyan, fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                    const Divider(height: 20, color: Colors.white24),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: (item['features'] as List).map((feat) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Row(
                            children: [
                              const Icon(Icons.check_circle_outline, size: 14, color: Colors.greenAccent),
                              const SizedBox(width: 6),
                              Text(feat.toString(), style: const TextStyle(fontSize: 12, color: Colors.white70)),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () => _showPurchaseDialog(context, item),
                        child: const Text('Beli Voucher Sekarang', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
