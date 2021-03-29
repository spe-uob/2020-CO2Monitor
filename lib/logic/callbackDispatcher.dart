import 'package:co2_monitor/logic/notificationProvider.dart';
import 'package:co2_monitor/logic/subscriptionProvider.dart';
import 'package:workmanager/workmanager.dart';

const int THRESHHOLD = 200;

/// This function is designed to be periodically called by the android system.
/// When this occurs, it checks to see which locations have critical status.
void callbackDispatcher() {
  Workmanager.executeTask((name, data) async {
    // Currently, the only task we have is 'co2alerts'

    var critical = List.empty();
    var locations = await SubscriptionProvider().subscriptions();

    // Locations where one devices is critical are also considered critical.
    for (var location in locations)
      if (await location.isCritical()) critical.add(location);

    if (critical.isNotEmpty) NotificationProvider().alert(critical);

    return true;
  });
}
