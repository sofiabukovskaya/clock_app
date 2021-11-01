import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  const ClockView({Key? key}) : super(key: key);

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  DateTime dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2; //set our center by height ands by width
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);
    double radius = min(centerX, centerY);

    Paint fillBrush = Paint()..color = const Color(0xFF444974);
    Paint outlineBrush = Paint()
      ..color = const Color(0xFFEAECFF)
      ..strokeWidth = 16
      ..style = PaintingStyle.stroke;
    Paint centerFillBrush = Paint()..color = const Color(0xFFEAECFF);

    Paint secHandBrush = Paint()
      ..color = Colors.orange.shade300
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Paint minHandBrush = Paint()
      ..shader = RadialGradient(colors: [Colors.blue, Colors.purple.shade100])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Paint hourHandBrush = Paint()
      ..shader = RadialGradient(colors: [Colors.pink, Colors.pink.shade200])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 16
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Paint dashBrash = Paint()
      ..color = Colors.white38
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    double secHandX = centerX + 80 * cos(dateTime.second * 6 * pi / 180);
    double secHandY = centerY + 80 * sin(dateTime.second * 6 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    double minHandX = centerX + 80 * cos(dateTime.minute * 6 * pi / 180);
    double minHandY = centerY + 80 * sin(dateTime.minute * 6 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    double hourHandX = centerX +
        60 * cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    double hourHandY = centerY +
        60 * sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    canvas.drawCircle(center, 16, centerFillBrush);

    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 14;

    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerY + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerY + innerCircleRadius * sin(i * pi / 180);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrash);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
