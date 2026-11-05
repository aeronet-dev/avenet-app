import 'package:flutter/material.dart';
import 'api_service.dart';

class StorePage extends StatelessWidget {
  const StorePage({super.key});

  void _buyPackage(BuildContext context, String title, double gbAmount, int price) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: Text('Konfirmasi Pembelian', style: const TextStyle(color: Colors.white)),
        content: Text(
          'Apakah Anda yakin ingin membeli $title seharga Rp ${price.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}?',
          style: const TextStyle(color: Colors.grey),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
            onPressed: () {
              // Tambah kuota ke ApiService
              ApiService.addQuota(gbAmount);
              Navigator.pop(context);
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Pembelian $title Berhasil! Kuota +$gbAmount GB ditambahkan.')),
              );
            },
            child: const Text('Bayar via QRIS', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Toko Paket Avenet',
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildPackageItem(context, 'Paket Harian (1 GB)', 'Masa Aktif: 1 Hari', 'Rp 5.000', 1.0, 5000),
          _buildPackageItem(context, 'Paket Hemat (5 GB)', 'Masa Aktif: 7 Hari', 'Rp 20.000', 5.0, 20000),
          _buildPackageItem(context, 'Paket Reguler (15 GB)', 'Masa Aktif: 30 Hari', 'Rp 45.000', 15.0, 45000),
          _buildPackageItem(context, 'Paket VIP Unlimited (50 GB)', 'Masa Aktif: 30 Hari', 'Rp 90.000', 50.0, 90000),
        ],
      ),
    );
  }

  Widget _buildPackageItem(BuildContext context, String title, String activePeriod, String price, double gbAmount, int rawPrice) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.cyan.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(activePeriod, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 8),
              Text(price, style: const TextStyle(color: Colors.greenAccent, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
            onPressed: () => _buyPackage(context, title, gbAmount, rawPrice),
            child: const Text('Beli', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
