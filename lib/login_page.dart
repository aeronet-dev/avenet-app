import 'package:flutter/material.dart';
import 'api_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _selectedMethod = 'Voucher';
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _handleLogin() {
    String user = _usernameController.text.trim();

    if (_selectedMethod == 'Voucher' && user.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kode Voucher tidak boleh kosong!')),
      );
      return;
    }

    if (_selectedMethod == 'Member' && user.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nomor WhatsApp / Akun Google tidak boleh kosong!')),
      );
      return;
    }

    // Simulasi Login Sukses & Catat Log
    ApiService.addAdminLog('Login berhasil menggunakan metode: $_selectedMethod');
    
    // Pindah ke menu utama setelah login
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101927),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Selamat Datang di Avenet',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Solusi akses internet cepat, aman, dan mudah.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF11E293B),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.cyan.withOpacity(0.2),
                        ),
                        child: const Icon(Icons.wifi, size: 45, color: Colors.cyan),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Avenet Net',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      
                      // Tombol Pilihan Metode Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: ['Voucher', 'Member', 'Iuran'].map((method) {
                          bool isSelected = _selectedMethod == method;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: ChoiceChip(
                              label: Text(method),
                              selected: isSelected,
                              selectedColor: Colors.cyan,
                              backgroundColor: const Color(0xFFF0F172A),
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.black : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              onSelected: (selected) {
                                setState(() {
                                  _selectedMethod = method;
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        _selectedMethod == 'Iuran'
                            ? 'Masukkan ID Pelanggan / Nomor Iuran'
                            : _selectedMethod == 'Member'
                                ? 'Masukkan Nomor WhatsApp / OTP'
                                : 'Masukkan Kode Voucher',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 20),

                      // Form Input Username / Nomor
                      TextField(
                        controller: _usernameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: _selectedMethod == 'Iuran' ? 'ID Pelanggan' : 'Akun / Voucher / WhatsApp',
                          labelStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(Icons.person_outline, color: Colors.cyan),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                          filled: true,
                          fillColor: const Color(0xFFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Form Input Password (jika bukan iuran)
                      if (_selectedMethod != 'Iuran') ...[
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Password / PIN',
                            labelStyle: const TextStyle(color: Colors.grey),
                            prefixIcon: const Icon(Icons.lock_outline, color: Colors.cyan),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            filled: true,
                            fillColor: const Color(0xFFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 25),
                      ] else ...[
                        const SizedBox(height: 15),
                      ],

                      // Tombol Submit
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: _handleLogin,
                          child: Text(
                            _selectedMethod == 'Iuran' ? 'Cek Status Iuran' : 'Masuk Sekarang',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
