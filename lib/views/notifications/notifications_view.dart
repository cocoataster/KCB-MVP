import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/utils/text_styles.dart';
import 'package:sounds_good/core/viewmodels/notifications_viewmodel.dart';

class NotificationsView extends StatefulWidget {
  NotificationsView({Key key}) : super(key: key);

  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  NotificationsViewModel notificationsViewModel = NotificationsViewModel();
  ScrollController _scrollController = ScrollController();

  int index;

  @override
  void initState() {
    super.initState();
    index = 0;

    notificationsViewModel.fetchNotificationPage(index);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          notificationsViewModel.hasMorePages()) {
        ++index;
        notificationsViewModel.fetchNotificationPage(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationsViewModel>(
        builder: (context) => notificationsViewModel,
        child: Consumer<NotificationsViewModel>(
          builder: (context, notificationsViewModel, child) => WillPopScope(
            onWillPop: () => Future(() => false),
            child: Scaffold(
              body: notificationsViewModel.state == ViewState.Idle
                  ? SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                              TextStrings.notifications_screen_title,
                              style: TextStyles.section_header,
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height - 140,
                            child: ListView.builder(
                                controller: _scrollController,
                                itemCount:
                                    notificationsViewModel.notifications.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var notification = notificationsViewModel
                                      .notifications[index];

                                  var image = notification.info.image != ''
                                      ? '${Api.endpoint}/${notification.info.image}'
                                      : 'assets/images/profile.png';

                                  var sender = notification.info.senderName !=
                                          ''
                                      ? notification.info.senderName
                                      : TextStrings.notifications_sender_empty;

                                  var buttonText = notification.state ==
                                          NotificationState.Pending
                                      ? TextStrings.notifications_actions_todo
                                      : TextStrings.notifications_actions_done;

                                  //print(notification.info.senderName);

                                  return NotificationsRow(
                                      id: notification.id,
                                      asset: image,
                                      notification: sender,
                                      button: buttonText,
                                      state: notification.state);
                                }),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
        ));
  }
}

class NotificationsRow extends StatelessWidget {
  final String id;
  final String asset;
  final String notification;
  final String button;
  final NotificationState state;

  NotificationsRow(
      {this.id, this.asset, this.notification, this.button, this.state});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationsViewModel>(
      builder: (context, model, child) => Container(
        child: Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: asset.contains('http')
                  ? Image.network(
                      asset,
                      height: 110,
                      alignment: Alignment(0.0, -1.0),
                      fit: BoxFit.fitHeight,
                    )
                  : Image.asset(
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
              onPressed: () {
                if (state == NotificationState.Pending) {
                  model.readNotification(id);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
