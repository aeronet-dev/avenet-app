import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil & Referal')),
      body: const Center(
        child: Text('Halaman Akun & Referal Avenet'),
      ),
    );
  }
}

