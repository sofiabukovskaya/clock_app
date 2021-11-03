import 'package:clock_app/app/pages/widgets/clock_view.dart';
import 'package:flutter/material.dart';

class ClockPage extends StatefulWidget {
  const ClockPage(
      {Key? key,
      required this.dateFormat,
      required this.dateFormatDay,
      required this.timeZoneString})
      : super(key: key);

  final String dateFormat;
  final String dateFormatDay;
  final String timeZoneString;
  @override
  State<ClockPage> createState() => _ClockPageState();
}

class _ClockPageState extends State<ClockPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: const Color(0xFF2D2F41),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Flexible(
            flex: 1,
            child: Text('Clock',
                style: TextStyle(
                    fontFamily: 'avenir', color: Colors.white, fontSize: 32)),
          ),
          const SizedBox(height: 32),
          Flexible(
            flex: 2,
            child: Text(widget.dateFormat,
                style: const TextStyle(
                    fontFamily: 'avenir', color: Colors.white, fontSize: 64)),
          ),
          Flexible(
            flex: 2,
            child: Text(widget.dateFormatDay,
                style: const TextStyle(
                    fontFamily: 'avenir', color: Colors.white, fontSize: 20)),
          ),
          const Align(alignment: Alignment.center, child: ClockView()),
          const Flexible(
            flex: 2,
            child: Text('Timezone',
                style: TextStyle(
                    fontFamily: 'avenir', color: Colors.white, fontSize: 24)),
          ),
          const SizedBox(height: 16),
          Flexible(
              flex: 2,
              child: Row(
                children: [
                  const Icon(Icons.language, color: Colors.white),
                  const SizedBox(width: 16),
                  Text('UTC+' + widget.timeZoneString,
                      style: const TextStyle(
                          fontFamily: 'avenir',
                          color: Colors.white,
                          fontSize: 14)),
                ],
              ))
        ],
      ),
    );
  }
}
