import 'package:flutter/material.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final List> _packages = [
    {'id': '1', 'title': 'VIP Weekly', 'quota': 'Unlimited', 'price': 'Rp 15.000'},
    {'id': '2', 'title': 'VIP Monthly', 'quota': 'Unlimited', 'price': 'Rp 45.000'},
  ];

  void _buyPackage(String id, String title, String price) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Store')),
      body: ListView.builder(
        itemCount: _packages.length,
        itemBuilder: (context, index) {
          final pkg = _packages[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(pkg['title'].toString()),
              subtitle: Text('Kuota: ${pkg['quota']} - ${pkg['price']}'),
              trailing: ElevatedButton(
                onPressed: () => _buyPackage(
                  pkg['id'].toString(),
                  pkg['title'].toString(),
                  pkg['price'].toString(),
                ),
                child: const Text('Beli'),
              ),
            ),
          );
        },
      ),
    );
  }
}
