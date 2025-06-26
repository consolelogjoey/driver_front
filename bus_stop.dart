import 'package:flutter/material.dart';
import 'bus_trip_go_page.dart';
import 'bus_trip_back_page.dart';

class SelectBusRoutePage extends StatelessWidget {
  const SelectBusRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF19747E),
      appBar: AppBar(
        backgroundColor: Colors.cyan[100],
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'ເລືອກຖ້ຽວລົດເມ',
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
        child: Column(
          children: [
            _routeButton(context, 'ຂາໄປ'),
            const SizedBox(height: 30),
            _routeButton(context, 'ຂາກັບ'),
          ],
        ),
      ),
    );
  }

  Widget _routeButton(BuildContext context, String label) {
    return GestureDetector(
      onTap: () {
        if (label == 'ຂາໄປ') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BusTripGoPage()),
          );
        } else if (label == 'ຂາກັບ') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BusTripBackPage()),
          );
        }
      },
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: const TextStyle(fontSize: 22, color: Colors.black),
        ),
      ),
    );
  }
}
