import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/notifications_viewmodel.dart';

class NotificationsView extends StatefulWidget {
  NotificationsView({Key key}) : super(key: key);

  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  NotificationsViewModel notificationsViewModel = NotificationsViewModel();

  List<Widget> items = [
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accept'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accepted'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: Text('Notifications',
                  style: Theme.of(context).textTheme.headline),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 140,
              child: PagewiseListView(
                pageSize: notificationsViewModel.limit,
                itemBuilder: (context, entry, index) {
                  var notification =
                      notificationsViewModel.notifications[index];

                  var image = notification.info.image != ''
                      ? notification.info.image
                      : 'assets/images/profile.png';

                  var sender = notification.info.senderName != ''
                      ? notification.info.senderName
                      : 'Sender is empty';

                  var buttonText =
                      notification.state == NotificationState.Pending
                          ? 'Accept'
                          : 'Accepted';

                  print(notification.info.senderName);

                  return NotificationsRow(
                    asset: image,
                    notification: sender,
                    button: buttonText,
                  );
                },
                pageFuture: (pageIndex) {
                  return notificationsViewModel
                      .fetchNotificationPage(pageIndex);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationsRow extends StatelessWidget {
  final String asset;
  final String notification;
  final String button;

  NotificationsRow({this.asset, this.notification, this.button});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              asset,
              height: 110,
              alignment: Alignment(0.0, -1.0),
              fit: BoxFit.fitHeight,
            ),
          ),
          title: Text(notification),
          trailing: RaisedButton(
            color: Colors.grey.shade300,
            child: Text(button,
                style: TextStyle(fontSize: 12, color: Colors.black)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () => {},
          ),
        ),
      ),
    );
  }
}
