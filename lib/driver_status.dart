import 'package:flutter/material.dart';

class DriverStatusPage extends StatelessWidget {
  const DriverStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_DriverStatusItem> statuses = [
      _DriverStatusItem(icon: Icons.play_circle_fill, label: 'ເລີ່ມວຽກ'),
      _DriverStatusItem(icon: Icons.pause_circle_filled, label: 'ພັກຜ່ອນ'),
      _DriverStatusItem(icon: Icons.stop_circle, label: 'ເລີກວຽກ'),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF19747E),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB2EBF2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ສະຖານະຄົນຂັບ',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: statuses.map((item) {
            return GestureDetector(
              onTap: () {
                // handle tap
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.cyan[50],
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item.icon, size: 40, color: Colors.teal),
                    const SizedBox(height: 12),
                    Text(
                      item.label,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _DriverStatusItem {
  final IconData icon;
  final String label;

  _DriverStatusItem({required this.icon, required this.label});
}
