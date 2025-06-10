import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:driver_app/bus_stations.dart';
import 'package:driver_app/bus_stop.dart';
import 'package:driver_app/driver_status.dart';

class BusWelcomeScreen extends StatefulWidget {
  final String driverId;

  const BusWelcomeScreen({super.key, required this.driverId});

  @override
  State<BusWelcomeScreen> createState() => _BusWelcomeScreenState();
}

class _BusWelcomeScreenState extends State<BusWelcomeScreen> {
  bool isLoading = true;
  String? error;
  Map<String, dynamic>? driverData;

  @override
  void initState() {
    super.initState();
    fetchDriverDetails();
  }

  Future<void> fetchDriverDetails() async {
    final url =
        Uri.parse('http://192.168.1.10:5000/api/driver/${widget.driverId}');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          driverData = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          error = "Failed to load driver info";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xFF19747E);
    final headerColor = const Color(0xFFB2EBF2);
    final boxColor = const Color(0xFFE0F7FA);

    return Scaffold(
      backgroundColor: bgColor,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 20),
                      decoration: BoxDecoration(
                        color: headerColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'ຍິນດີຕ້ອນຮັບ\nທ່ານເຂົ້າສູ່ລະບົບແລ້ວ',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text('ຊື່ພະນັກງານ: ທ. ${driverData!['driver_name']}'),
                          const SizedBox(height: 10),
                          Text('ເບີໂທ: ${driverData!['driver_phone']}'),
                          const SizedBox(height: 10),
                          Text(
                              'ປະແພດລົດ: ລົດມີ ${driverData!['bus_type_capacity']} ບ່ອນນັ່ງ'),
                          const SizedBox(height: 10),
                          Text('ເລກລົດ: ${driverData!['bus_number']}'),
                          const SizedBox(height: 10),
                          Text('ປ້າຍທະບຽນ: ${driverData!['bus_plate']}'),
                          const SizedBox(height: 10),
                          Center(
                            child: Image.asset(
                              'images/joey.jpg',
                              height: 60,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BusStationPage()),
                                  );
                                },
                                child: const MenuBox(
                                    icon: Icons.directions_bus,
                                    label: 'ປ້າຍລົດ'),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BusStatusPage()),
                                  );
                                },
                                child: const MenuBox(
                                    icon: Icons.verified_user,
                                    label: 'ສະຖານະລົດ'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DriverStatusPage()),
                                  );
                                },
                                child: const MenuBox(
                                    icon: Icons.person, label: 'ສະຖານະຄົນຂັບ'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}

class MenuBox extends StatelessWidget {
  final IconData icon;
  final String label;

  const MenuBox({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 130,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F7FA),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.teal),
          const SizedBox(height: 10),
          Text(label, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
