import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_catalog/constants.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter_catalog/my_app_settings.dart';
import 'package:flutter_catalog/my_route_search_delegate.dart';
import 'package:flutter_catalog/routes/about.dart';
import 'package:provider/provider.dart';
import 'package:widget_with_codeview/widget_with_codeview.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:day_night_switcher/day_night_switcher.dart';

class MyRoute extends StatelessWidget {
  static const _kFrontLayerMinHeight = 128.0;
  final String sourceFilePath;
  final Widget child;
  final String? _title;
  final String description;
  final Map<String, String> links;
  final String? _routeName;
  final Iterable<PlatformType> supportedPlatforms;

  const MyRoute({Key? key,
    required this.sourceFilePath,
    required this.child,
    String? title,
    this.description = '',
    this.links = const <String, String>{},
    String? routeName,
    this.supportedPlatforms = PlatformType.values})
      : _title = title,
        _routeName = routeName,
        super(key: key);

  String get routeName =>
      this._routeName ?? '/${this.child.runtimeType.toString()}';

  String get title => _title ?? this.routeName;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final appbarLeading = (kPaltformType == PlatformType.Android ||
        this.routeName == Navigator.defaultRouteName)
        ? null
        : IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(Icons.arrow_back));

    return BackdropScaffold(
        appBar: BackdropAppBar(
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(this.title),
          ),
          actions: _getAppbarActions(context),
          automaticallyImplyLeading: false,
          leading: appbarLeading,
        ),
        headerHeight: _kFrontLayerMinHeight,
        frontLayerBorderRadius: BorderRadius.zero,
        backLayer: _getBackdropListTiles(),
        frontLayer: Builder(
          builder: (BuildContext context) =>
          routeName == Navigator.defaultRouteName
              ? this.child
              : WidgetWithCodeView(
            child: this.child,
            sourceFilePath: this.sourceFilePath,
            codeLinkPrefix: '$GITHUB_URL/blob/master',
          ),
        ));
  }

  List<Widget> _getAppbarActions(BuildContext context) {
    final settings = Provider.of<MyAppSettings>(context);
    return <Widget>[
      const BackdropToggleButton(),
      if (this.routeName == Navigator.defaultRouteName)
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () async {
            await showSearch<String>(
              context: context,
              delegate: MyRouteSearchDelegate(),
            );
          },
        ),
      if (this.routeName != Navigator.defaultRouteName)
        settings.starStatusOfRoute(this.routeName),
      if (this.links.isNotEmpty)
        PopupMenuButton(
          itemBuilder: (context) {
            return <PopupMenuItem>[
              for (MapEntry<String, String> titleAndLink in this.links.entries)
                PopupMenuItem(
                  child: ListTile(
                    title: Text(titleAndLink.key),
                    trailing: IconButton(
                      icon: const Icon(Icons.open_in_new),
                      tooltip: titleAndLink.value,
                      onPressed: () => url_launcher.launch(titleAndLink.value),
                    ),
                    onTap: () => url_launcher.launch(titleAndLink.value),
                  ),
                )
            ];
          },
        ),
    ];
  }

  ListView _getBackdropListTiles() {
    return ListView(
      padding: EdgeInsets.only(bottom: _kFrontLayerMinHeight),
      children: [
        ListTile(
          leading: kAppIcon,
          title: Text(APP_NAME),
          subtitle: Text(APP_VERSION),
        ),
        ...MyAboutRoute.kAboutTitles,
        Consumer<MyAppSettings>(
            builder: (context, MyAppSettings settings, _) {
              return ListTile(
                onTap: () {},
                leading: DayNightSwitcherIcon(
                  isDarkModeEnabled: settings.isDarkMode,
                  onStateChanged: (_) {},
                ),
                title: Text('Dark mode ${settings.isDarkMode ? 'on' : 'off'}'),
                trailing: DayNightSwitcher(
                  isDarkModeEnabled: settings.isDarkMode,
                  onStateChanged: (bool value) => settings.setDarkMode(value),
                ),
              );
            }
        ),
      ],
    );
  }
}
