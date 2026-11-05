// 1. Bagian Kotak Status Masa Aktif Waktu (Menggantikan Sisa Kuota GB)
Container(
  padding: const EdgeInsets.all(16),
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

// 2. Bagian Tombol Klaim Free Trial 30 Menit
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
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    decoration: BoxDecoration(
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

// 3. Logika Tombol "Hubungkan Sekarang"
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.cyan,
    padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 14),
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
        // Logika menghubungkan VPN
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Menghubungkan ke server VPN...'),
          backgroundColor: Colors.green,
        ),
      );
    }
  },
  child: const Text(
    'Hubungkan Sekarang',
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
  ),
),

