// Holds all network state and the HTTP client
import 'dart:convert';

import 'package:http/http.dart';
import 'package:co2_monitor/api/types/location.dart';
import 'package:co2_monitor/api/types/device.dart';
import 'package:co2_monitor/api/types/reading.dart';

// Singleton client that all data classes use
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  Client _httpClient;

  ApiClient._internal() {
    _httpClient = Client();
  }

  factory ApiClient() => _instance;

  Future<List<Location>> getLocations(String endpoint) async {
    var res = await _httpClient.get("");
    return jsonDecode(res.body).map((loc) => Location.fromJson(loc));
  }

  Future<Location> getLocation(String endpoint) async {
    var res = await _httpClient.get("");
    return Location.fromJson(jsonDecode(res.body));
  }

  Future<List<Device>> getDevices(String endpoint) async {
    var res = await _httpClient.get("");
    return jsonDecode(res.body).map((dev) => Device.fromJson(dev));
  }

  Future<Device> getDevice(String endpoint) async {
    var res = await _httpClient.get("");
    return Device.fromJson(jsonDecode(res.body));
  }

  Future<List<Reading>> getReadings(String endpoint) async {
    var res = await _httpClient.get("");
    return jsonDecode(res.body).map((rea) => Reading.fromJson(rea));
  }

  Future<Reading> getReading(String endpoint) async {
    var res = await _httpClient.get("");
    return Reading.fromJson(jsonDecode(res.body));
  }
}
