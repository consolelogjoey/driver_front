import 'package:flutter/material.dart';

class BusStationPage extends StatelessWidget {
  const BusStationPage({super.key});

  final List<Map<String, dynamic>> busRoutes = const [
    {"number": "056", "route": "ມາວັດດອມບາງ", "enabled": true},
    {"number": "056", "route": "ມາວັດດອມບາງ", "enabled": true},
    {"number": "056", "route": "ມາວັດດອມບາງ", "enabled": true},
    {"number": "056", "route": "ມາວັດດອມບາງ", "enabled": true},
    {"number": "056", "route": "ມາວັດດອມບາງ", "enabled": false},
    {"number": "056", "route": "ມາວັດດອມບາງ", "enabled": false},
    {"number": "056", "route": "ມາວັດດອມບາງ", "enabled": false},
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ListView.separated(
          itemCount: busRoutes.length,
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            final bus = busRoutes[index];
            final isEnabled = bus["enabled"] as bool;

            return Container(
              decoration: BoxDecoration(
                color: isEnabled ? Colors.white : Colors.grey[300],
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    bus["number"],
                    style: TextStyle(
                      color: isEnabled ? Colors.red : Colors.red.shade200,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      bus["route"],
                      style: TextStyle(
                        color: isEnabled ? Colors.black : Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
