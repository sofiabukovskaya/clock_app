import 'package:clock_app/app/data/enums/menu_type_enum.dart';
import 'package:clock_app/app/data/models/menu_info.dart';
import 'package:clock_app/app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Clock app',
        debugShowCheckedModeBanner: false,
        home: ChangeNotifierProvider<MenuInfo>(
          create: (context) => MenuInfo(MenuType.clock),
          child: const HomePage(),
        ));
  }
}
