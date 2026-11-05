class ApiService {
  // Sistem Waktu Durasi Voucher (Pengganti Kuota GB)
  static double sisaWaktu = 0.0; // Dalam Menit

  // Variabel Pendukung Dashboard & Free Trial
  static bool isFreeTrialClaimed = false;
  static double sisaKuota = 0.0;
  static double totalServerQuota = 100.0;

  // Daftar Voucher Manual & Durasi Menitnya
  static final Map<String, double> validVouchers = {
    'AVENET2H': 120.0,   // 2 Jam
    'AVENET7H': 420.0,   // 7 Jam
    'AVENET1D': 1440.0,  // 24 Jam (1 Hari)
    'AVENET7D': 10080.0, // 7 Hari
  };

  static bool redeemVoucherCode(String code) {
    String cleanCode = code.trim().toUpperCase();
    if (validVouchers.containsKey(cleanCode)) {
      double minutes = validVouchers[cleanCode]!;
      sisaWaktu += minutes;
      addAdminLog('Voucher berhasil direndeem: $cleanCode (+${minutes.toStringAsFixed(0)} Menit)');
      return true;
    }
    return false;
  }

  // Fungsi Klaim Free Trial yang dicari oleh Dashboard
  static bool claimFreeTrial() {
    if (!isFreeTrialClaimed) {
      sisaWaktu += 30.0; // Berikan free trial 30 menit
      isFreeTrialClaimed = true;
      return true;
    }
    return false;
  }

  // Fungsi Durasi Waktu & Kuota
  static void tambahWaktu(double menit) {
    sisaWaktu += menit;
    isFreeTrialClaimed = true;
  }

  static void kurangiWaktu(double menit) {
    if (sisaWaktu > 0) {
      sisaWaktu -= menit;
      if (sisaWaktu < 0) sisaWaktu = 0.0;
    }
  }

  static void addQuota(double amount) {
    sisaKuota += amount;
  }

  // Variabel Pendukung Halaman Profil, Admin, & Hotspot
  static bool isServerMaintenance = false;
  static List<String> adminLogs = [];
  static String referralCode = 'AVENET2026';
  static bool isHotspotActive = false;
  static int connectedDevices = 0;

  // Fungsi Pendukung Admin & Hotspot
  static void addAdminLog(String log) {
    adminLogs.insert(0, '${DateTime.now().toString().substring(11, 19)} - $log');
  }

  static void toggleServerMaintenance() {
    isServerMaintenance = !isServerMaintenance;
    addAdminLog(isServerMaintenance ? 'Server diatur ke Mode Maintenance' : 'Server dinormalkan kembali');
  }

  static void toggleHotspot() {
    isHotspotActive = !isHotspotActive;
    connectedDevices = isHotspotActive ? 1 : 0;
  }

  static bool verifyAdminPin(String pin) {
    return pin == '1234';
  }
}
