import 'package:co2_monitor/logic/subscriptionProvider.dart';
import 'package:test/test.dart';

void main() {
  SubscriptionProvider data = SubscriptionProvider();
  // Clear file before
  setUp(() async => await data.unsubscribeAll());

  test('Empty Subscriptions', () async {
    // Pick some arbitrary values, include edge cases.
    // Note that Dart is platform-agnostic, there is no 'INT_MAX' constant.
    assert(!await data.isSubscribedTo(0));
    assert(!await data.isSubscribedTo(5));
    assert(!await data.isSubscribedTo(27));
  });

  test('Insert Subscriptions', () async {
    await data.subscribeTo(2);
    await data.subscribeTo(3);
    assert(await data.isSubscribedTo(2));
    assert(await data.isSubscribedTo(3));
  });

  test('Cycle Subscriptions', () async {
    await data.subscribeTo(4);
    assert(await data.isSubscribedTo(4));
    assert((await data.subscriptions()).contains(4));
    await data.unsubscribeFrom(4);
    assert(!await data.isSubscribedTo(4));
    assert(!(await data.subscriptions()).contains(4));
    await data.subscribeTo(4);
    assert(await data.isSubscribedTo(4));
    assert((await data.subscriptions()).contains(4));
  });

  test('Get Subscriptions', () async {
    assert((await data.subscriptions()).isEmpty);
    await data.subscribeTo(5);
    await data.subscribeTo(4);
    await data.subscribeTo(1);

    var subs = await data.subscriptions();
    expect(subs, containsAll([1, 5, 4]));
    expect(subs, hasLength(3));
  });
}
