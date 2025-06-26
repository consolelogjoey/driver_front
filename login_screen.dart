import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';
import '../provider/provider.dart';
import '../services/active_driver_api.dart'; // Add this import for backend sync

class DriverLoginPage extends StatefulWidget {
  const DriverLoginPage({super.key});

  @override
  State<DriverLoginPage> createState() => _DriverLoginPageState();
}

class _DriverLoginPageState extends State<DriverLoginPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorMessage;
  bool isLoading = false;

  Future<void> loginDriver() async {
    final name = nameController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = "⚠️ Please enter all fields.";
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final baseUrl = dotenv.env['API_BASE_URL'];
    if (baseUrl == null) {
      setState(() {
        errorMessage = "API base URL not found in .env file.";
        isLoading = false;
      });
      return;
    }

    final url = Uri.parse("$baseUrl/api/login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "driver_name": name,
          "driver_password": password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final driver = data['driver'];

        if (driver == null || driver['driver_id'] == null) {
          setState(() {
            errorMessage = "❌ Missing driver ID from server.";
          });
          return;
        }

        // Get full driver info
        final String driverId = driver['driver_id'].toString();
        final String driverName = driver['driver_name'];
        final String busId = driver['bus_id']?.toString() ?? "";
        final String routeId = driver['route_id']?.toString() ?? "";

        // ✅ Update Provider with full info
        Provider.of<DriverProvider>(context, listen: false).setDriverInfo(
          driverId: driverId,
          driverName: driverName,
          busId: busId,
          routeId: routeId,
        );

        // ✅ Sync to backend active_drivers table
        await ActiveDriverApi.updateActiveDriver(context);

        // ✅ Navigate to main screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BusWelcomeScreen(),
          ),
        );
      } else {
        final data = jsonDecode(response.body);
        setState(() {
          errorMessage = data['error'] ?? "❌ Login failed.";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "❌ Network error: $e";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00778B),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(Icons.directions_bus_filled,
                    color: Colors.green, size: 100),
                const SizedBox(height: 40),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'ຊື່ຜູ້ໃຊ້ງານ....',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'ລະຫັດຜ່ານ....',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (errorMessage != null)
                  Text(errorMessage!,
                      style: const TextStyle(color: Colors.red)),
                if (isLoading) const CircularProgressIndicator(),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : loginDriver,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF78E08F),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('ເຂົ້າລະບົບ'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
