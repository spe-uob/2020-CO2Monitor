import 'dart:convert';
import 'dart:io';
import 'package:co2_monitor/api/client.dart';
import 'package:co2_monitor/api/types/location.dart';
import 'package:path_provider/path_provider.dart';

/// This class provides the ability to:
/// - Update user location subscriptions in a non-volatile manner.
/// - Query if the user is subscribed to a given location.
/// - Fetch all locations a user is subscribed to.
/// It uses a simple JSON file to keep track of subscribed location IDs.
class SubscriptionProvider {
  /// Singleton instance.
  static final SubscriptionProvider _instance =
      SubscriptionProvider._internal();

  factory SubscriptionProvider() => _instance;
  SubscriptionProvider._internal();

  static String filename = "subscriptions.json";

  Future<File> _dataPath() async {
    var directory = await getApplicationDocumentsDirectory();
    var f = File("${directory.path}/$filename");
    if (!await f.exists()) {
      // Do not remove this call: this will cause infinite recursion.
      // Specifically, unsubscribeAll will call this function, and recurse.
      await f.create();
      // UnsubscribeAll fill the new file with valid JSON.
      await unsubscribeAll();
    }
    return f;
  }

  Future<dynamic> _readJson() async {
    // Read latest version from file
    var file = await _dataPath();
    var contents = await file.readAsString();
    return jsonDecode(contents);
  }

  // Future<dynamic> _writeJson(dynamic json) =>
  //     _dataPath().then((f) => f.writeAsString(jsonEncode(json)));

  Future<dynamic> _write(List<int> values) =>
      _dataPath().then((f) => f.writeAsString(jsonEncode(values)));

  Future subscribeTo(int id) async {
    if (await isSubscribedTo(id)) return;
    var curr = await subscriptionIds();
    curr.add(id);
    await _write(curr);
  }

  Future unsubscribeFrom(int id) async {
    if (!await isSubscribedTo(id)) return;
    var curr = await subscriptionIds();
    curr.remove(id);
    await _write(curr);
  }

  Future unsubscribeAll() async {
    await _write(List.empty());
  }

  /// Obtain a list of all locations a user is subscribed to.
  Future<List<int>> subscriptionIds() async {
    List<int> json = (await _readJson()).cast<int>();
    // TODO: Handle invalid JSON by regenerating empty file
    // This could display a notification?
    return json;
  }

  /// Utility method, because we probably do this a lot
  /// Wraps `subscriptionIds` and converts into locations.
  Future<List<Location>> subscriptions() async {
    var client = ApiClient();
    var subIds = await subscriptionIds();
    return await Future.wait(subIds.map((id) => client.getLocation(id)));
  }

  Future<bool> isSubscribedTo(int id) async =>
      (await subscriptionIds()).contains(id);

  /// Subscribe to a location if unsubscribed, or unsubscribe if subscribed.
  /// This function returns the new subscription status, i.e. it returns
  /// true if the location was not previously subscribed to, but now is.
  Future<bool> toggleSubscription(int id) async {
    var subbed = await isSubscribedTo(id);
    if (subbed)
      await unsubscribeFrom(id);
    else
      await subscribeTo(id);
    return !subbed;
  }
}
