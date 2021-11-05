import 'package:clock_app/app/data/data.dart';
import 'package:clock_app/main.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64, horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Alarm',
              style: TextStyle(
                  fontFamily: 'avenir', color: Colors.white, fontSize: 32)),
          Expanded(
            child: ListView(
                children: alarmInfoItems.map<Widget>((alarm) {
              String alarmTime =
                  DateFormat('hh:mm aa').format(alarm.alarmDateTime);
              return Container(
                margin: const EdgeInsets.only(bottom: 32),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: alarm.gradientColor!,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                          color: alarm.gradientColor!.last.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(4, 4),
                          spreadRadius: 4)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.label,
                                color: Colors.white, size: 24),
                            const SizedBox(width: 8),
                            Text(
                              alarm.description!,
                              style: const TextStyle(
                                  fontFamily: 'avenir', color: Colors.white),
                            ),
                          ],
                        ),
                        Switch(
                          value: true,
                          onChanged: (bool value) => {},
                          activeColor: Colors.white,
                        )
                      ],
                    ),
                    const Text(
                      'Mon-Fri',
                      style:
                          TextStyle(fontFamily: 'avenir', color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          alarmTime,
                          style: const TextStyle(
                              fontFamily: 'avenir',
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 24),
                        ),
                        const Icon(Icons.keyboard_arrow_down,
                            color: Colors.white, size: 36)
                      ],
                    ),
                  ],
                ),
              );
            }).followedBy([_addAlarmButton()]).toList()),
          )
        ],
      ),
    );
  }

  Widget _addAlarmButton() {
    return DottedBorder(
      strokeWidth: 3,
      color: Colors.white70,
      borderType: BorderType.RRect,
      dashPattern: const [5, 4],
      radius: const Radius.circular(24),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Color(0xFF444974),
            borderRadius: BorderRadius.all(Radius.circular(24))),
        child: TextButton(
          onPressed: () => scheduledNotification(),
          child: Column(
            children: [
              Image.asset('assets/images/add_alarm.png', scale: 1.5),
              const SizedBox(height: 8),
              const Text(
                'Add alarm',
                style: TextStyle(fontFamily: 'avenir', color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void scheduledNotification() async {
    DateTime timeNotification = DateTime.now().add(const Duration(seconds: 5));

    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails('alarm_notif', 'alarm_notif',
            channelDescription: 'Channel for alarm notification',
            icon: 'Flutter',
            largeIcon: DrawableResourceAndroidBitmap('Flutter'));

    IOSNotificationDetails iosNotificationDetails = const IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true
    );

    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails, iOS: iosNotificationDetails);

    await flutterLocalNotificationsPlugin.schedule(0, 'Office', 'Good morning!', timeNotification, notificationDetails);
  }
}
