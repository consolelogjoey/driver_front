import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../provider/provider.dart';

class ActiveDriverApi {
  static Future<void> updateActiveDriver(BuildContext context) async {
    final driverProvider = Provider.of<DriverProvider>(context, listen: false);

    final url =
        Uri.parse("https://driver.phoudthasone.com/api/active-drivers/update");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "driver_id": driverProvider.driverId,
        "bus_id": driverProvider.busId,
        "route_id": driverProvider.routeId,
        "trip_id": driverProvider.tripId,
      }),
    );

    if (response.statusCode != 200) {
      print("Failed to update active driver: ${response.body}");
    }
  }
}
