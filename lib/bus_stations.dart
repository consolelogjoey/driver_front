import 'package:flutter/material.dart';

class BusStatusPage extends StatelessWidget {
  const BusStatusPage({super.key});

  final List<_BusStatusItem> statuses = const [
    _BusStatusItem(icon: Icons.access_time, label: "ລໍຖ້າ"),
    _BusStatusItem(icon: Icons.directions_bus_filled, label: "ກຳລັງເດີນທາງ"),
    _BusStatusItem(icon: Icons.flag, label: "ຮອດປ້າຍທາງ"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF19747E),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB2EBF2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ສະຖານະລົດເມ',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: statuses.map((item) {
            return GestureDetector(
              onTap: () {
                // handle tap if needed
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

class _BusStatusItem {
  final IconData icon;
  final String label;

  const _BusStatusItem({required this.icon, required this.label});
}
