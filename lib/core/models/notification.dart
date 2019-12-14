import 'package:sounds_good/core/models/notification_info.dart';
import 'package:sounds_good/core/utils/enums.dart';

class Notification {
  final String id;
  NotificationType type;
  String receiverId;
  DateTime dateAdded;
  NotificationState state;
  NotificationInfo info;

  Notification({
    this.id,
    this.type,
    this.receiverId,
    this.dateAdded,
    this.state,
    this.info,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    NotificationType notificationType = json['notificationType'] == 'follow'
        ? NotificationType.Follow
        : NotificationType.Other;

    DateTime date = DateTime.parse(json['dateAdded']);

    NotificationState notificationState = json['state'] == 'pending'
        ? NotificationState.Pending
        : NotificationState.Redeemed;

    NotificationInfo notificationInfo = json['data'] != null
        ? NotificationInfo.fromJson(json['data'])
        : NotificationInfo();

    return Notification(
      id: json['cuid'],
      type: notificationType,
      receiverId: json['destination'],
      dateAdded: date,
      state: notificationState,
      info: notificationInfo,
    );
  }
}
