class ApiService {
  // Mengubah dari kuota GB ke sisa waktu aktif (dalam Menit)
  static double sisaWaktu = 0.0; // 0 artinya habis/belum aktif

  // Fungsi untuk menambah waktu (misal klaim free trial 30 menit)
  static void tambahWaktu(double menit) {
    sisaWaktu += menit;
  }

  // Fungsi simulasi potong waktu saat VPN aktif
  static void kurangiWaktu(double menit) {
    if (sisaWaktu > 0) {
      sisaWaktu -= menit;
      if (sisaWaktu < 0) sisaWaktu = 0.0;
    }
  }
}
