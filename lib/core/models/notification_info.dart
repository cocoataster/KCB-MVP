class NotificationInfo {
  String image;
  String senderId;
  String senderName;
  String receiverId;
  String receiverName;

  NotificationInfo({
    this.image,
    this.senderId,
    this.senderName,
    this.receiverId,
    this.receiverName,
  });

  factory NotificationInfo.fromJson(Map<String, dynamic> json) {
    return NotificationInfo(
      image: json['image'] != null ? json['image'] : '',
      senderId: json['origin'] != null ? json['origin'] : '',
      senderName: json['originName'] != null ? json['originName'] : '',
      receiverId: json['destination'] != null ? json['destination'] : '',
      receiverName:
          json['destinationName'] != null ? json['destinationName'] : '',
    );
  }
}
