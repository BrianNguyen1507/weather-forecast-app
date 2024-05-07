import 'package:flutter/material.dart';

class LocationProvider extends ChangeNotifier {
  List<String> _locations = [];

  List<String> get locations => _locations;

  void addLocation(String location) {
    _locations.add(location);
    notifyListeners();
  }

  void loadLocations(List<String> savedLocations) {
    _locations = savedLocations;
    notifyListeners();
  }
}
