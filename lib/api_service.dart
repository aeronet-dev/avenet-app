class ApiService {
  // Sistem Waktu Durasi Voucher (Pengganti Kuota GB)
  static double sisaWaktu = 0.0; // Dalam Menit

  // Fungsi Durasi Waktu
  static void tambahWaktu(double menit) {
    sisaWaktu += menit;
  }

  static void kurangiWaktu(double menit) {
    if (sisaWaktu > 0) {
      sisaWaktu -= menit;
      if (sisaWaktu < 0) sisaWaktu = 0.0;
    }
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
}
