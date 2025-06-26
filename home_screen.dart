import 'dart:convert';
import 'package:driver_app/bus_stop.dart';
import 'package:driver_app/driver_status.dart';
import 'package:driver_app/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

class BusWelcomeScreen extends StatefulWidget {
  const BusWelcomeScreen({super.key});

  @override
  State<BusWelcomeScreen> createState() => _BusWelcomeScreenState();
}

class _BusWelcomeScreenState extends State<BusWelcomeScreen> {
  bool isLoading = true;
  Map<String, dynamic>? driverData;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchDriverDetails();
  }

  Future<void> fetchDriverDetails() async {
    final driverProvider = Provider.of<DriverProvider>(context, listen: false);
    final driverId = driverProvider.driverId;

    if (driverId == null) {
      setState(() {
        error = "Driver ID not found in Provider.";
        isLoading = false;
      });
      return;
    }

    final baseUrl = dotenv.env['API_BASE_URL'];
    final url = Uri.parse('$baseUrl/api/dashboard/$driverId');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          driverData = jsonDecode(response.body);
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
    final driverProvider = Provider.of<DriverProvider>(context);
    final driverId = driverProvider.driverId ?? "";

    return Scaffold(
      backgroundColor: const Color(0xFF19747E),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(
                  child:
                      Text(error!, style: const TextStyle(color: Colors.red)))
              : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(40),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color(0xFFB2EBF2),
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(40)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text('ຍິນດີຕ້ອນຮັບ',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          const Text('ທ່ານເຂົ້າສູ່ລະບົບແລ້ວ',
                              style: TextStyle(fontSize: 18)),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Icon(Icons.person, size: 40),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('ຊື່: ${driverData!['driver_name']}',
                                        style: const TextStyle(fontSize: 16)),
                                    Text('ເບີ: ${driverData!['driver_phone']}',
                                        style: const TextStyle(fontSize: 16)),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.directions_bus, size: 40),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        'ປະເພດລົດ: ${driverData!['bus_type_capacity']} ບ່ອນນັ່ງ',
                                        style: const TextStyle(fontSize: 16)),
                                    Text(
                                        'ປ້າຍລົດ: ${driverData!['bus_number']}',
                                        style: const TextStyle(fontSize: 16)),
                                    Text(
                                        'ປ້າຍທະບຽນ: ${driverData!['bus_plate']}',
                                        style: const TextStyle(fontSize: 16)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text("ລາຍການ",
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SelectBusRoutePage()),
                            );
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: const Color(0xFFB2EBF2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.directions_bus,
                                    size: 50, color: Colors.teal),
                                SizedBox(height: 10),
                                Text("ປ້າຍລົດເມ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DriverStatusPage(driverId: ''),
                              ),
                            );
                          },
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: const Color(0xFFB2EBF2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.person,
                                    size: 50, color: Colors.teal),
                                SizedBox(height: 10),
                                Text("ສະຖານະຄົນຂັບ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
    );
  }
}

// Dummy DriverStatusPage for example

