// Holds all network state and the HTTP client
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:co2_monitor/api/types/location.dart';
import 'package:co2_monitor/api/types/device.dart';

/// Singleton API client that all data classes use.
class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  Client _httpClient;

  factory ApiClient() => _instance;
  ApiClient._internal() {
    _httpClient = Client();
  }

  /// API URL base endpoint
  static String _apiUrl = "https://100.25.147.253:8080/api/v1";

  /// Safely perform a GET request on a given URL
  Future<Response> _getReq(String url) async {
    try {
      var res = await _httpClient.get(url);
      switch (res.statusCode) {
        case HttpStatus.ok:
          return res;
        // TODO: More granular errors, please!
        default:
          throw HttpException("${res.statusCode}");
      }
    } on Exception {
      return null;
    }
  }

  /// Wraps _getReq and parses into a given type
  /// Involves type-level hackery
  Future<T> getOne<T>(String url) async {
    var res = await _getReq(url);
    return (T as dynamic)?.fromJson(jsonDecode(res?.body));
  }

  /// Wraps _getReq and parses into an array of a given type
  /// Involves type-level hackery
  Future<List<T>> getMany<T>(String url) async {
    var res = await _getReq(url);
    return jsonDecode(res?.body)
        .map((val) => (T as dynamic)?.fromJson(val))
        .toList();
  }

  Future<List<Location>> getLocations() =>
      getMany("$_apiUrl/buildings/1/rooms");

  // Future<Location> getLocation(int id) => getOne("$_apiUrl/rooms/$id");
  Future<Location> getLocation(int id) => getOne("$_apiUrl/rooms/$id");

  Future<List<Device>> getDevices() => getMany("$_apiUrl/sensors");
  Future<Device> getDevice(int id) => getOne("$_apiUrl/sensors/$id");

  // Future<List<Device>> getReadings() => getMany("$_apiUrl/reading");
  Future<Device> getReading(int deviceId, int id) =>
      getOne("$_apiUrl/sensors/$deviceId/readings/$id");
}
