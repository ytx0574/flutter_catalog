import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/my_app_routes.dart';
import 'package:flutter_catalog/my_app_settings.dart';

class MyMainApp extends StatelessWidget {
  final MyAppSettings settings;

  const MyMainApp(this.settings, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _MyMaterialApp();
  }
}

class _MyMaterialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ss = kAppRoutingTable;
    return MaterialApp(
      title: 'Flutter Catalog',
      routes: ss,
    );
  }
}
