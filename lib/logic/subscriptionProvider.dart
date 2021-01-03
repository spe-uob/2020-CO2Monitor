import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// This class provides the ability to:
// - Update user location subscriptions in a non-volatile manner.
// - Query if the user is subscribed to a given location.
// - Fetch all locations a user is subscribed to.
// It uses a simple JSON file to keep track of subscribed location IDs.
class SubscriptionProvider {
  // Singleton instance for this class
  static final SubscriptionProvider _instance =
      SubscriptionProvider._internal();

  SubscriptionProvider._internal();
  factory SubscriptionProvider() => _instance;

  static String filename = "subscriptions.json";

  Future<File> _dataPath() async {
    var directory = await getApplicationDocumentsDirectory();
    var f = File("${directory.path}/$filename");
    // UnsubscribeAll creates the file and fills it with valid JSON.
    if (!await f.exists()) await unsubscribeAll();
    return f;
  }

  Future<dynamic> _readJson() async {
    // Read latest version from file
    var file = await _dataPath();
    var contents = await file.readAsString();
    return jsonDecode(contents);
  }

  Future<dynamic> _writeJson(dynamic json) =>
      _dataPath().then((f) => f.writeAsString(jsonEncode(json)));

  Future<dynamic> _write(List<int> values) =>
      _dataPath().then((f) => f.writeAsString(jsonEncode(values)));

  Future subscribeTo(int id) async {
    if (await isSubscribedTo(id)) return;
    var curr = await subscriptions();
    curr.add(id);
    await _write(curr);
  }

  Future unsubscribeFrom(int id) async {
    if (!await isSubscribedTo(id)) return;
    var curr = await subscriptions();
    curr.remove(id);
    await _write(curr);
  }

  Future unsubscribeAll() async {
    await _write(List.empty());
  }

  Future<List<int>> subscriptions() async {
    List<int> json = (await _readJson()).cast<int>();
    // TODO: Handle invalid JSON by regenerating empty file
    return json;
  }

  Future<bool> isSubscribedTo(int id) async =>
      (await subscriptions()).contains(id);
}
