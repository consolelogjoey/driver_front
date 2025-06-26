import 'package:flutter/material.dart';

class DriverProvider with ChangeNotifier {
  String? _driverId;
  String? _driverName;
  String? _busId;
  String? _routeId;
  String? _tripId;

  // Getters
  String? get driverId => _driverId;
  String? get driverName => _driverName;
  String? get busId => _busId;
  String? get routeId => _routeId;
  String? get tripId => _tripId;

  // Setter for login info
  void setDriverInfo({
    required String driverId,
    required String driverName,
    required String busId,
    required String routeId,
  }) {
    _driverId = driverId;
    _driverName = driverName;
    _busId = busId;
    _routeId = routeId;
    notifyListeners();
  }

  // Setter for trip start
  void setTripId(String tripId) {
    _tripId = tripId;
    notifyListeners();
  }

  void clearAll() {
    _driverId = null;
    _driverName = null;
    _busId = null;
    _routeId = null;
    _tripId = null;
    notifyListeners();
  }
}
