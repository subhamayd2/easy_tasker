import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:easy_tasker/add_reminder.dart';
import 'package:easy_tasker/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:easy_tasker/home.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.dark,
        data: (Brightness _brightness) {
          final isDark = _brightness == Brightness.dark;
          Brightness statusBarIcon =
              isDark ? Brightness.light : Brightness.dark;
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarBrightness: _brightness,
              statusBarIconBrightness: statusBarIcon,
              statusBarColor: Color.fromARGB(50, 0, 0, 0),
            ),
          );
          return new ThemeData(
            primarySwatch: Colors.teal,
            accentColor: Colors.tealAccent[700],
            brightness: _brightness,
            scaffoldBackgroundColor: isDark ? Colors.black : Colors.grey[200],
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              foregroundColor: Colors.white,
            ),
            appBarTheme: AppBarTheme(
              color: Colors.transparent,
              elevation: 0.0,
              iconTheme: Theme.of(context).iconTheme.copyWith(
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
            ),
          );
        },
        themedWidgetBuilder: (context, theme) {
          return new MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Easy Tracker",
              theme: theme,
              initialRoute: '/',
              onGenerateRoute: (RouteSettings settings) {
                var routes = <String, WidgetBuilder>{
                  '/': (context) => SplashScreen(),
                  '/home': (context) => Home(),
                  '/add': (context) => AddReminder(),
                  // '/details': (context) => ReminderDetails(settings.arguments),
                };
                WidgetBuilder builder = routes[settings.name];
                return MaterialPageRoute(builder: (ctx) => builder(ctx));
              });
        });
  }
}
