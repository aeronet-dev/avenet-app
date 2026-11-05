class ApiService {
  // Data simulasi akun pengguna
  static double sisaKuota = 0.0; // dalam GB
  static bool isFreeTrialClaimed = false;
  static String referralCode = 'AVENET2026';
  static int connectedDevices = 0;
  static bool isHotspotActive = false;

  // Keamanan Admin Panel
  static const String _adminPin = '123456'; // PIN Rahasia Admin
  static double totalServerQuota = 500.0; // Total Kapasitas Server (GB)
  static bool isServerMaintenance = false; // Status Server Utama

  // Verifikasi PIN Admin
  static bool verifyAdminPin(String pin) {
    return pin == _adminPin;
  }

  // Fungsi untuk klaim Free Trial 50MB
  static bool claimFreeTrial() {
    if (!isFreeTrialClaimed) {
      isFreeTrialClaimed = true;
      sisaKuota += 0.05; // Tambah 50 MB
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
