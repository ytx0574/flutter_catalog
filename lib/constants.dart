import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:flutter/material.dart';

const APP_VERSION = 'v3.1.1';
const APP_NAME = 'Flutter Catalog';
final kAppIcon =
Image.asset('res/images/launcher_icon.png', height: 64.0, width: 64.0);
const APP_DESCRIPTION = 'An app showcasing Flutter components, with '
    'side-by-side source code view.'
    '\n\nDeveloped by X.Wei.';
const GOOGLEPLAY_URL =
    'https://play.google.com/store/apps/details?id=io.github.x_wei.flutter_catalog';
const GITHUB_URL = 'https://github.com/X-Wei/flutter_catalog';
const AUTHOR_SITE = 'http://x-wei.github.io';

enum PlatformType { Web, iOS, Android, MacOS, Fuchsia, Linux, Windows, Unknown }

final kPaltformType = getCurrentPlatformType();

PlatformType getCurrentPlatformType() {
  if(kIsWeb) {
    return PlatformType.Web;
  }
  if (Platform.isMacOS) {
    return PlatformType.MacOS;
  }

  if (Platform.isFuchsia) {
    return PlatformType.Fuchsia;
  }

  if (Platform.isLinux) {
    return PlatformType.Linux;
  }

  if (Platform.isWindows) {
    return PlatformType.Windows;
  }

  if (Platform.isIOS) {
    return PlatformType.iOS;
  }

  if (Platform.isAndroid) {
    return PlatformType.Android;
  }

  return PlatformType.Unknown;
}