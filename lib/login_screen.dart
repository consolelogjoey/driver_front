import 'dart:convert';
import 'package:driver_app/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

    final url = Uri.parse("http://192.168.1.10:5000/api");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "driver_name": name,
          "driver_password": password,
        }),
      );

      print("Status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        try {
          final data = jsonDecode(response.body);

          final driverIdRaw = data['driver_id'];
          if (driverIdRaw == null) {
            setState(() {
              errorMessage = "❌ Missing driver ID from server.";
            });
            return;
          }

          final String driverId = driverIdRaw.toString();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BusWelcomeScreen(driverId: driverId),
            ),
          );
        } catch (e) {
          setState(() {
            errorMessage = "❌ Failed to parse server response.";
          });
        }
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

                // Username Field
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
                const SizedBox(height: 20),

                // Password Field
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
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
                const SizedBox(height: 20),

                // Error Message
                if (errorMessage != null)
                  Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                if (isLoading) const CircularProgressIndicator(),

                const SizedBox(height: 20),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : loginDriver,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF78E08F),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text('ເຂົ້າລະບົບ'),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
