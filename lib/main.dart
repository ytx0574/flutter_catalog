import 'package:flutter/material.dart';
import 'package:flutter_catalog/my_app_settings.dart';

import 'my_main_app.dart';

void main() async {
  final settings = await MyAppSettings.create();
  return runApp(MyMainApp(settings));
}
