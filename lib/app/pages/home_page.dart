import 'package:clock_app/app/data/data.dart';
import 'package:clock_app/app/data/enums/menu_type_enum.dart';
import 'package:clock_app/app/pages/alarm_page.dart';
import 'package:clock_app/app/pages/clock_page.dart';
import 'package:clock_app/app/pages/widgets/menu_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:clock_app/app/data/models/menu_info.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static DateTime dateTimeNow = DateTime.now();

  String dateFormat = DateFormat('HH:mm').format(dateTimeNow);
  String dateFormatDay = DateFormat('EEE, d MMM').format(dateTimeNow);
  String timeZoneString =
      dateTimeNow.timeZoneOffset.toString().split('.').first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2F41),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Column(
                children: menuInfoItems
                    .map((currentMenuInfo) =>
                        MenuButtonWidget(currentMenuInfo: currentMenuInfo))
                    .toList()),
          ),
          const VerticalDivider(
            width: 1,
            color: Colors.white60,
          ),
          _mainContent()
        ],
      ),
    );
  }

  Widget _mainContent() {
    return Expanded(
      child: Consumer<MenuInfo>(
        builder: (BuildContext context, MenuInfo value, Widget? child) {
          if (value.menuType == MenuType.clock) {
            return ClockPage(
                dateFormat: dateFormat,
                dateFormatDay: dateFormatDay,
                timeZoneString: timeZoneString);
          } else if (value.menuType == MenuType.alarm) {
            return const AlarmPage();
          }
          return Container();
        },
      ),
    );
  }
}
