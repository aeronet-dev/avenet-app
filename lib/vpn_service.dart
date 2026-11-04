class VpnServiceManager {
  static bool isConnected = false;

  static Future<bool> connect({String server = 'proxy.avenet.vpn', String protocol = 'VLESS'}) async {
    // Simulasi langsung sukses terhubung tanpa menunggu channel native
    await Future.delayed(const Duration(milliseconds: 500));
    isConnected = true;
    return true;
  }

  static Future<bool> disconnect() async {
    await Future.delayed(const Duration(milliseconds: 300));
    isConnected = false;
    return false;
  }
}

