import 'package:clock_app/app/data/enums/menu_type_enum.dart';
import 'package:flutter/foundation.dart';

class MenuInfo extends ChangeNotifier {
  MenuInfo(this.menuType, {this.title, this.imageSource});

  MenuType menuType;
  String? title;
  String? imageSource;

  updateMenuInfo(MenuInfo menuInfo) {
    menuType = menuInfo.menuType;
    title = menuInfo.title;
    imageSource = menuInfo.imageSource;

    notifyListeners();
  }
}
