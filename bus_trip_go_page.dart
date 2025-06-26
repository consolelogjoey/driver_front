import 'package:flutter/material.dart';

class BusTripGoPage extends StatelessWidget {
  const BusTripGoPage({super.key});

  final List<Map<String, dynamic>> busStopList = const [
    {"label": "bus station"},
    {"label": "bus stop 1"},
    {"label": "bus stop 2"},
    {"label": "bus stop 3"},
    {"label": "bus stop 4"},
  ];

  final List<Map<String, String>> busRoutes = const [
    {"number": "056", "route": "ມາວັດດອມບາງ"},
    {"number": "056", "route": "ມາວັດດອມບາງ"},
    {"number": "056", "route": "ມາວັດດອມບາງ"},
    {"number": "056", "route": "ມາວັດດອມບາງ"},
    {"number": "056", "route": "ມາວັດດອມບາງ"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF19747E),
      appBar: AppBar(
        backgroundColor: Colors.cyan[100],
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'ຂາໄປ',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top white buttons
              Column(
                children: busStopList.map((bus) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      bus["label"],
                      style: const TextStyle(fontSize: 18),
                    ),
                  );
                }).toList(),
              ),
              Column(
                children: busRoutes.map((bus) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Text(
                          bus["number"]!,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          bus["route"]!,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
