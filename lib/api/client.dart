// Holds all network state and the HTTP client
import 'dart:convert';
import 'dart:io';

import 'package:co2_monitor/api/types/reading.dart';
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
    var res = await _httpClient.get(url);
    switch (res.statusCode) {
      case HttpStatus.ok:
        return res;
      // TODO: More granular errors, please!
      default:
        throw HttpException("${res.statusCode}");
    }
  }

  /// Wraps _getReq and parses into a given type
  Future<T> getOne<T>(
      T Function(Map<String, dynamic> json) fromJson, String url) async {
    var res = await _getReq(url);
    return fromJson(jsonDecode(res?.body));
  }

  /// Wraps _getReq and parses into an array of a given type
  Future<List<T>> getMany<T>(
      T Function(Map<String, dynamic> json) fromJson, String url) async {
    var res = await _getReq(url);
    return List.from(jsonDecode(res?.body).map((val) => fromJson(val)));
  }

  Future<List<Location>> getLocations() =>
      getMany((j) => Location.fromJson(j), "$_apiUrl/buildings/1/rooms");

  // Future<Location> getLocation(int id) => getOne("$_apiUrl/rooms/$id");
  Future<Location> getLocation(int id) =>
      getOne((j) => Location.fromJson(j), "$_apiUrl/rooms/$id");

  Future<List<Device>> getDevices() =>
      getMany((j) => Device.fromJson(j), "$_apiUrl/sensors");
  Future<Device> getDevice(int id) =>
      getOne((j) => Device.fromJson(j), "$_apiUrl/sensors/$id");

  // Future<List<Device>> getReadings() => getMany("$_apiUrl/reading");
  Future<Reading> getReading(int deviceId, int id) => getOne(
      (j) => Reading.fromJson(j), "$_apiUrl/sensors/$deviceId/readings/$id");
}
