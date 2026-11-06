class ApiService {
  // Simulasi masa aktif internet (dalam jam)
  static double sisaWaktuAktif = 5.0;

  // Variabel status tambahan yang dipanggil oleh profile_page.dart
  static bool isServerMaintenance = false;
  static String referralCode = 'AVENET99';
  static bool isHotspotActive = true;
  static int connectedDevices = 1;

  // Daftar database kode voucher manual yang valid beserta durasinya (dalam jam)
  static final Map<String, double> validVouchers = {
    'AVENET2H': 2.0,   // Paket Kilat 2 Jam
    'AVENET7H': 7.0,   // Paket Hemat 7 Jam
    'AVENET24H': 24.0, // Paket Harian 24 Jam
    'AVENET1W': 168.0, // Paket Mingguan
  };

  static List<String> adminLogs = [];

  // Fungsi untuk menambah waktu masa aktif
  static void tambahWaktu(double hours) {
    sisaWaktuAktif += hours;
  }

  // Fungsi untuk validasi dan redeem voucher manual
  static bool redeemVoucherCode(String code) {
    String upperCode = code.trim().toUpperCase();
    if (validVouchers.containsKey(upperCode)) {
      double hours = validVouchers[upperCode]!;
      tambahWaktu(hours);
      addAdminLog('Berhasil redeem voucher manual: $upperCode (+$hours Jam)');
      return true;
    }
    return false;
  }

  static void addAdminLog(String log) {
    adminLogs.insert(0, '[${DateTime.now().toString().substring(11, 16)}] $log');
  }
}
