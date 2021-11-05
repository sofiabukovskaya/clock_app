import 'package:clock_app/app/data/alarm_db.dart';
import 'package:clock_app/app/data/data.dart';
import 'package:clock_app/app/data/models/alarm_info.dart';
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
  DateTime? _alarmTime;
  String? _alarmTimeString;
  final AlarmDB _alarmHelper = AlarmDB();
  Future<List<AlarmInfo>>? _alarms;
  List<AlarmInfo>? _currentAlarms;

  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      loadAlarms();
    });
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

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
            child: FutureBuilder<List<AlarmInfo>>(
              future: _alarms,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _currentAlarms = snapshot.data;
                  return ListView(
                      children: alarmInfoItems.map<Widget>((alarm) {
                    String alarmTime =
                        DateFormat('hh:mm aa').format(alarm.alarmDateTime!);
                    return Container(
                      margin: const EdgeInsets.only(bottom: 32),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: alarm.gradientColor!,
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(24)),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    alarm.gradientColor!.last.withOpacity(0.4),
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
                                    alarm.title!,
                                    style: const TextStyle(
                                        fontFamily: 'avenir',
                                        color: Colors.white),
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
                            style: TextStyle(
                                fontFamily: 'avenir', color: Colors.white),
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
                  }).followedBy([
                    if (_currentAlarms!.length < 5)
                      DottedBorder(
                        strokeWidth: 2,
                        color: Colors.white70,
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(24),
                        dashPattern: const [5, 4],
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Color(0xFF444974),
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                          ),
                          child: FlatButton(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            onPressed: () {
                              _alarmTimeString =
                                  DateFormat('HH:mm').format(DateTime.now());
                              showModalBottomSheet(
                                useRootNavigator: true,
                                context: context,
                                clipBehavior: Clip.antiAlias,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(24),
                                  ),
                                ),
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setModalState) {
                                      return Container(
                                        padding: const EdgeInsets.all(32),
                                        child: Column(
                                          children: [
                                            FlatButton(
                                              onPressed: () async {
                                                var selectedTime =
                                                    await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                );
                                                if (selectedTime != null) {
                                                  final now = DateTime.now();
                                                  var selectedDateTime =
                                                      DateTime(
                                                          now.year,
                                                          now.month,
                                                          now.day,
                                                          selectedTime.hour,
                                                          selectedTime.minute);
                                                  _alarmTime = selectedDateTime;
                                                  setModalState(() {
                                                    _alarmTimeString =
                                                        DateFormat('HH:mm')
                                                            .format(
                                                                selectedDateTime);
                                                  });
                                                }
                                              },
                                              child: Text(
                                                _alarmTimeString!,
                                                style: const TextStyle(
                                                    fontSize: 32),
                                              ),
                                            ),
                                            const ListTile(
                                              title: Text('Repeat'),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                            ),
                                            const ListTile(
                                              title: Text('Sound'),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                            ),
                                            const ListTile(
                                              title: Text('Title'),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                            ),
                                            FloatingActionButton.extended(
                                              onPressed: onSaveAlarm,
                                              icon: const Icon(Icons.alarm),
                                              label: const Text('Save'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                              // scheduleAlarm();
                            },
                            child: Column(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/add_alarm.png',
                                  scale: 1.5,
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Add Alarm',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'avenir'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      const Center(
                          child: Text(
                        'Only 5 alarms allowed!',
                        style: TextStyle(color: Colors.white),
                      )),
                  ]).toList());
                }
                return const Center(
                  child: Text(
                    'Loading..',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'alarm_notif',
      'alarm_notif',
      channelDescription: 'Channel for Android notif',
      icon: 'codex_logo',
      sound: RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: DrawableResourceAndroidBitmap('codex_logo'),
    );

    IOSNotificationDetails iOSPlatformChannelSpecifics =
        const IOSNotificationDetails(
            sound: 'a_long_cold_sting.wav',
            presentAlert: true,
            presentBadge: true,
            presentSound: true);
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(0, 'Office', alarmInfo.title,
        scheduledNotificationDateTime, platformChannelSpecifics);
  }

  void onSaveAlarm() {
    DateTime scheduleAlarmDateTime;
    if (_alarmTime!.isAfter(DateTime.now())) {
      scheduleAlarmDateTime = _alarmTime!;
    } else {
      scheduleAlarmDateTime = _alarmTime!.add(const Duration(days: 1));
    }

    AlarmInfo alarmInfo = AlarmInfo(
      alarmDateTime: scheduleAlarmDateTime,
      title: 'alarm',
    );
    _alarmHelper.insertAlarm(alarmInfo);
    scheduleAlarm(scheduleAlarmDateTime, alarmInfo);
    Navigator.pop(context);
    loadAlarms();
  }

  void deleteAlarm(int id) {
    _alarmHelper.delete(id);
    loadAlarms();
  }
}
