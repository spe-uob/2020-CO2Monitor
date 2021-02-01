import 'package:co2_monitor/api/client.dart';
import 'package:co2_monitor/api/types/device.dart';
import 'package:co2_monitor/logic/notificationProvider.dart';
import 'package:co2_monitor/logic/subscriptionProvider.dart';
import 'package:workmanager/workmanager.dart';

const int THRESHHOLD = 20;

/// This function is designed to be periodically called by the android system.
/// When this occurs, it checks to see which locations have critical status.
void callbackDispatcher() {
  Workmanager.executeTask((name, data) async {
    // Currently, the only task we have is 'co2alerts'

    var client = ApiClient();
    var subIds = await SubscriptionProvider().subscriptions();
    // It's supposed to get some values from the server, check them vs. a...
    // ...threshhold, and send an alert if so. However, there is no such server.
    // Therefore, this should be considered TODO and is a placeholder.
    List<Device> devices;
    var critical = List.empty();
    for (var d in devices)
      if ((await d.latestReading()).isCritical) critical.add(d);

    if (critical.isNotEmpty) NotificationProvider().alert(critical);

    return true;
  });
}
