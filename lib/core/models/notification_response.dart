import 'notification.dart';

class NotificationResponse {
  final int total;
  final int offset;
  final List<MemberNotification> notifications;

  NotificationResponse({this.total, this.offset, this.notifications});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<MemberNotification> notifications = [];

    notifications = list
        .map(
            (jsonNotification) => MemberNotification.fromJson(jsonNotification))
        .toList();

    return NotificationResponse(
        total: json['total'],
        offset: json['offset'],
        notifications: notifications);
  }
}
