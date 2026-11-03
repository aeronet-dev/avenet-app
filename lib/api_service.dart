import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Ganti dengan URL endpoint backend / server X-UI Anda nantinya
  static const String baseUrl = 'https://api.avenet-vpn.com/v1';

  // Fungsi untuk mengambil data profil dan status kuota pengguna
  static Future> fetchUserProfile(String userId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users/$userId'));
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Gagal memuat data profil');
      }
    } catch (e) {
      // Data dummy fallback untuk pengujian awal jika server belum aktif
      return {
        'username': 'AvenetUser',
        'quota_gb': 15.5,
        'expired_date': '2026-12-31',
        'referral_code': 'AVENET88',
        'referral_earnings': 45000,
      };
    }
  }

  // Fungsi untuk melakukan simulasi pembelian paket via QRIS
  static Future<bool> purchasePackage(String packageId, String paymentMethod) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/store/buy'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'package_id': packageId,
          'payment_method': paymentMethod,
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      // Simulasi sukses untuk pengujian frontend toko QRIS
      await Future.delayed(const Duration(seconds: 1));
      return true;
    }
  }
}
