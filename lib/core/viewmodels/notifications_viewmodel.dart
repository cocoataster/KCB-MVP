import 'package:sounds_good/core/models/notification_response.dart';
import 'package:sounds_good/core/models/notification.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/base_viewmodel.dart';

class NotificationsViewModel extends BaseViewModel {
  Api _api = Api();

  final limit = 10;
  int offset = 0;
  int total = 0;

  List<MemberNotification> notifications = [];

  void fetchNotificationPage(pageIndex) async {
    setState(ViewState.Busy);
    offset = pageIndex * limit;
    NotificationResponse notificationResponse =
        await _api.getNotifications(limit, offset);

    notificationResponse.notifications
        .map((notification) => notifications.add(notification))
        .toList();

    total = notificationResponse.total;
    setState(ViewState.Idle);
  }

  Future<bool> readNotification(String id) async {
    setState(ViewState.Busy);

    MemberNotification notification = await _api.redeemNotification(id);

    if (notification.state == NotificationState.Redeemed) {
      resetNotificationList();
      setState(ViewState.Idle);
      return true;
    } else {
      setState(ViewState.Idle);
      return false;
    }
  }

  void resetNotificationList() {
    offset = 0;
    notifications = [];
    fetchNotificationPage(offset);
  }

  bool hasMorePages() {
    return offset + limit < total;
  }
}
