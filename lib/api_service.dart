class ApiService {
  // Sistem Waktu Durasi Voucher (Pengganti Kuota GB)
  static double sisaWaktu = 0.0; // Dalam Menit

  // Variabel Pendukung Dashboard & Free Trial
  static bool isFreeTrialClaimed = false;
  static double sisaKuota = 0.0;
  static double totalServerQuota = 100.0;

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
