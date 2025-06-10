import 'package:flutter/material.dart';

class BusStationPage extends StatelessWidget {
  const BusStationPage({super.key});

  final List<Map<String, String>> busRoutes = const [
    {"number": "056", "route": "ມາວັດດອມບາງ"},
    {"number": "058", "route": "ບ.ສີບົວວັງ"},
    {"number": "060", "route": "ບ.ສີສັງວອນ"},
    {"number": "", "route": "Coming Soon..."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF19747E),
      appBar: AppBar(
        backgroundColor: Colors.cyan[100],
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'ປ້າຍລົດເມ',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: busRoutes.map((bus) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.cyan[50],
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.directions_bus,
                      size: 35, color: Colors.teal),
                  const SizedBox(height: 8),
                  Text(
                    bus["number"]!,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    bus["route"]!,
                    style: const TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
