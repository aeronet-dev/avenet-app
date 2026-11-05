class ApiService {
  // Data simulasi akun pengguna
  static double Masa Aktif: habis; // Belum Aktif
  static bool isFreeTrialClaimed = false;
  static String referralCode = 'AVENET2026';
  static int connectedDevices = 0;
  static bool isHotspotActive = false;

  // Keamanan Admin Panel
  static const String _adminPin = '123456'; // PIN Rahasia Admin
  static double totalServerQuota = 500.0; // Total Kapasitas Server (GB)
  static bool isServerMaintenance = false; // Status Server Utama
  
  // Log Riwayat Aktivitas Admin
  static List<String> adminLogs = [];

  // Verifikasi PIN Admin
  static bool verifyAdminPin(String pin) {
    return pin == _adminPin;
  }

  // Fungsi untuk mencatat log admin
  static void addAdminLog(String activity) {
    String timestamp = "${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}:${DateTime.now().second.toString().padLeft(2, '0')}";
    adminLogs.insert(0, "[$timestamp] $activity");
    if (adminLogs.length > 10) {
      adminLogs.removeLast(); // Batasi maksimal 10 log terakhir
    }
  }

  // Fungsi untuk klaim Free Trial 30Menit
  static bool claimFreeTrial() {
    if (!isFreeTrialClaimed) {
      isFreeTrialClaimed = true;
      sisawaktu += 30.00; // Tambah 30 Menit
      addAdminLog("Pengguna klaim Free Trial 30Menit");
      return true;
    }
    return false;
  }

  // Fungsi simulasi top-up kuota dari Toko
  static void addQuota(double amountInGB) {
    sisaKuota += amountInGB;
  }

  // Fungsi untuk mengaktifkan/menonaktifkan Hotspot
  static void toggleHotspot() {
    isHotspotActive = !isHotspotActive;
    connectedDevices = isHotspotActive ? 2 : 0;
  }
}
