import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import '../provider/provider.dart';

class DriverStatusPage extends StatelessWidget {
  const DriverStatusPage({super.key, required String driverId});

  Future<void> updateDriverStatus(
      BuildContext context, String laoStatus) async {
    final driverId =
        Provider.of<DriverProvider>(context, listen: false).driverId;

    if (driverId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Driver ID not found")),
      );
      return;
    }

    final baseUrl = dotenv.env['API_BASE_URL'];
    if (baseUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("API base URL not configured")),
      );
      return;
    }
    final url = Uri.parse('$baseUrl/api/driver/status/$driverId');

    String status;
    if (laoStatus == 'ເລີ່ມວຽກ') {
      status = 'active';
    } else if (laoStatus == 'ເລີກວຽກ') {
      status = 'inactive';
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid status")),
      );
      return;
    }

    try {
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"driver_status": status}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Status updated to \"$laoStatus\"")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> statuses = ['ເລີ່ມວຽກ', 'ເລີກວຽກ'];

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
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatusButton(context, statuses[0],
                () => updateDriverStatus(context, statuses[0])),
            const SizedBox(width: 20),
            _buildStatusButton(context, statuses[1],
                () => updateDriverStatus(context, statuses[1])),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusButton(
      BuildContext context, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.cyan[50],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
