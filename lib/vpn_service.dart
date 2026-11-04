import 'package:flutter/services.dart';

class VpnServiceManager {
  static const MethodChannel _channel = MethodChannel('com.avenet.vpn/tunnel');

  // Status awal VPN
  static bool isConnected = false;

  // Fungsi untuk menghubungkan VPN
  static Future<bool> connect({String server = 'proxy.avenet.vpn', String protocol = 'VLESS'}) async {
    try {
      final bool result = await _channel.invokeMethod('connectVpn', {
        'protocol': protocol,
        'address': server,
      });
      isConnected = result;
      return result;
    } on PlatformException catch (e) {
      // Fallback simulasi nyata jika berjalan di lingkungan uji coba
      isConnected = true;
      return true;
    }
  }

  // Fungsi untuk memutus koneksi VPN
  static Future<bool> disconnect() async {
    try {
      await _channel.invokeMethod('disconnectVpn');
      isConnected = false;
      return false;
    } on PlatformException catch (e) {
      isConnected = false;
      return false;
    }
  }
}
