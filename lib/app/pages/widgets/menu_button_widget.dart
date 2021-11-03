import 'package:clock_app/app/data/models/menu_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuButtonWidget extends StatelessWidget {
  const MenuButtonWidget({Key? key, required this.currentMenuInfo})
      : super(key: key);
  final MenuInfo currentMenuInfo;

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuInfo>(
      builder: (BuildContext context, MenuInfo value, Widget? child) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: TextButton(
                onPressed: () {
                  MenuInfo menuInfo =
                      Provider.of<MenuInfo>(context, listen: false);
                  menuInfo.updateMenuInfo(currentMenuInfo);
                },
                style: ButtonStyle(
                  backgroundColor: currentMenuInfo.menuType == value.menuType
                      ? MaterialStateProperty.all(const Color(0xFF444974))
                      : MaterialStateProperty.all(Colors.transparent),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(currentMenuInfo.imageSource!, scale: 1.5),
                    Text(currentMenuInfo.title!,
                        style: const TextStyle(
                            fontFamily: 'avenir',
                            color: Colors.white,
                            fontSize: 14))
                  ],
                )));
      },
    );
  }
}
