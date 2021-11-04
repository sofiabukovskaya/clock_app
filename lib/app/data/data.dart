import 'package:clock_app/app/data/models/alarm_info.dart';
import 'package:clock_app/app/data/models/menu_info.dart';
import 'package:flutter/material.dart';

import 'enums/menu_type_enum.dart';

List<MenuInfo> menuInfoItems = [
  MenuInfo(MenuType.clock,
      title: 'Clock', imageSource: 'assets/images/clock_icon.png'),
  MenuInfo(MenuType.alarm,
      title: 'Alarm', imageSource: 'assets/images/alarm_icon.png'),
  MenuInfo(MenuType.stopwatch,
      title: 'Stopwatch', imageSource: 'assets/images/stopwatch_icon.png'),
  MenuInfo(MenuType.timer,
      title: 'Timer', imageSource: 'assets/images/timer_icon.png')
];

List<AlarmInfo> alarmInfoItems = [
  AlarmInfo(DateTime.now().add(const Duration(hours: 1)),
      description: 'Office',
      gradientColor: [Colors.lightBlueAccent.shade400, Colors.purple.shade500]),
  AlarmInfo(DateTime.now().add(const Duration(hours: 2)),
      description: 'Sport',
      gradientColor: [Colors.purple.shade600, Colors.red.shade500])
];
