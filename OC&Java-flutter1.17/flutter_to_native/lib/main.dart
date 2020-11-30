import 'dart:async';

import 'package:flutter/material.dart';

import 'home_page.dart';
import 'dart:ui';

import 'login_page.dart';
void main() {
  runApp(MyApp(route: window.defaultRouteName));
}

class MyApp extends StatelessWidget {
  final String route;

  const MyApp({Key key, this.route}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:route == "/"? HomePage(route: route,):LoginPage(route: route,),
    );
  }
}
@pragma('vm:entry-point')
void biz1() {
  FlutterError.onError = (details) async {
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };
  runZoned<void>(biz);
}
void biz() => runApp(MyApp(route: '<=biz1=>'+window.defaultRouteName));
