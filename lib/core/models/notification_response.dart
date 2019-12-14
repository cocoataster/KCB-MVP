import 'notification.dart';

class NotificationResponse {
  final int total;
  final int offset;
  final List<Notification> notifications;

  NotificationResponse({this.total, this.offset, this.notifications});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<Notification> notifications = [];

    notifications = list
        .map((jsonNotification) => Notification.fromJson(jsonNotification))
        .toList();

    return NotificationResponse(
        total: json['total'],
        offset: json['offset'],
        notifications: notifications);
  }
}
