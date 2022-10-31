import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:easy_tasker/constants.dart';
import 'package:flutter/material.dart';

class Appbar extends StatelessWidget with PreferredSizeWidget {
  final bottom;

  Appbar({this.bottom});

  _getBackButton(context) {
    if (!ModalRoute.of(context).canPop) {
      return null;
    } else {
      return IconButton(
        icon: Icon(Icons.chevron_left),
        iconSize: 32.0,
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      );
    }
  }

  double _getSize() {
    if (bottom == null) {
      return APPBAR_HEIGHT;
    }
    return APPBAR_HEIGHT + 85;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = DynamicTheme.of(context).brightness == Brightness.dark;
    return PreferredSize(
      preferredSize: Size.fromHeight(_getSize()),
      child: Container(
        padding: const EdgeInsets.only(bottom: 20.0),
        color: isDark ? Colors.white10 : Colors.black12.withAlpha(15),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: _getBackButton(context),
          iconTheme:
              IconThemeData(color: Theme.of(context).textTheme.display1.color),
          centerTitle: true,
          elevation: 0.0,
          title: Image.asset(
            "assets/logo.png",
            fit: BoxFit.contain,
            height: APPBAR_HEIGHT,
          ),
          bottom: bottom,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.brightness_medium),
              onPressed: () {
                var newBrigtness = isDark ? Brightness.light : Brightness.dark;
                DynamicTheme.of(context).setBrightness(newBrigtness);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_getSize());
}
