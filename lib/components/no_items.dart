import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

class NoItem extends StatelessWidget {
  final double opacity;
  final String text;
  final IconData iconData;

  NoItem({
    @required this.opacity,
    this.text,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = DynamicTheme.of(context).brightness == Brightness.dark;
    return AnimatedOpacity(
      duration: Duration(seconds: 1),
      opacity: opacity,
      child: Center(
        child: SizedBox(
          height: 256,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Opacity(
                opacity: isDark ? 0.08 : 0.2,
                child: Image.asset(
                  "assets/icon_bg.png",
                  fit: BoxFit.contain,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: 0.2,
                    child: Icon(
                      iconData ?? Icons.extension,
                      size: 52,
                    ),
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: Text(
                      text ?? "no reminders",
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
