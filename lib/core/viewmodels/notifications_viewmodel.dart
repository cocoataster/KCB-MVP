import 'package:sounds_good/core/models/notification_response.dart';
import 'package:sounds_good/core/models/notification.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/base_viewmodel.dart';

class NotificationsViewModel extends BaseViewModel {
  Api _api = Api();

  final limit = 10;
  int offset = 0;

  List<Notification> notifications = [];

  Future<List<Notification>> fetchNotificationPage(pageIndex) async {
    setState(ViewState.Busy);
    offset = pageIndex * limit;
    NotificationResponse notificationResponse =
        await _api.getNotifications(limit, offset);

    notifications += notificationResponse.notifications;
    ++offset;
    setState(ViewState.Idle);

    return notificationResponse.notifications;
  }
}
