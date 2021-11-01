import 'package:clock_app/app/pages/home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Clock app',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }

}