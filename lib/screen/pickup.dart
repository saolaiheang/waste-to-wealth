import 'package:flutter/material.dart';

class PickupPage extends StatelessWidget {
  const PickupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pickup'),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text('This is the Pickup page.'),
      ),
    );
  }
}
