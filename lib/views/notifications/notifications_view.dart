import 'package:flutter/material.dart';

class NotificationsView extends StatefulWidget {
  NotificationsView({Key key}) : super(key: key);

  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  List<Widget> items = [
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accept'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accepted'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accept'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accepted'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accept'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accepted'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accept'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accepted'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accept'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accepted'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accept'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accepted'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accept'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accepted'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accept'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accepted'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accept'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accepted'),
        NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accept'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accepted'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accept'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accepted'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accept'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accepted'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accept'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accepted'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accept'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accepted'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accept'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accepted'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accept'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accepted'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accept'),
    NotificationsRow(
        asset: 'assets/images/profile.png',
        notification: 'Paquito wants to join your band!',
        button: 'Accepted'),
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
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return items[index];
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
