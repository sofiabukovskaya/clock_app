import 'package:clock_app/app/data/data.dart';
import 'package:flutter/material.dart';

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
                children: alarmInfoItems.map((alarm) {
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
                      children: const [
                        Text(
                          '7:00 AM',
                          style: TextStyle(
                              fontFamily: 'avenir',
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 24),
                        ),
                        Icon(Icons.keyboard_arrow_down,
                            color: Colors.white, size: 36)
                      ],
                    ),
                  ],
                ),
              );
            }).followedBy([
              Container(
                color: Colors.red,
                height: 100,
                width: 100,
              )
            ]).toList()),
          )
        ],
      ),
    );
  }
}
