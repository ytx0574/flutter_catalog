import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_catalog/constants.dart';
import 'package:flutter_catalog/home_page.dart';
import 'package:flutter_catalog/my_route.dart';
import 'package:flutter_catalog/routes/about.dart';

class MyRouteGroup {
  const MyRouteGroup(
      {required this.groupName, required this.icon, required this.routes});

  final String groupName;
  final Widget icon;
  final List<MyRoute> routes;
}

const kHomeRoute = MyRoute(
  sourceFilePath: 'lib/routes/home.dart',
  title: APP_NAME,
  routeName: Navigator.defaultRouteName,
  child: MyHomePage(),
);

final kAbouteRoute = MyRoute(
  sourceFilePath: 'lib/routes/about.dart',
  title: 'About',
  links: {
    'Doc': 'https://docs.flutter.io/flutter/material/showAboutDialog.html'
  },
  child: MyAboutRoute(),
);


const kMyAppRoutesBasic = <MyRouteGroup>[
  MyRouteGroup(
      groupName: 'Widgets',
      icon: Icon(Icons.extension),
      routes: <MyRoute>[
        MyRoute(
            sourceFilePath: 'lib/routes/widgets_icon_ex.dart',
            child: Text('data'),
            title : 'Icon'
        ),
      ]),
  MyRouteGroup(
      groupName: 'Layouts',
      icon: Icon(Icons.dashboard),
      routes: <MyRoute>[
        MyRoute(
          sourceFilePath: 'sourceFilePath',
          child: Text('sss'),
          title: 'Containner',
          description: 'Basic widgets for layout.',
          links: {
            'Doc': 'https://docs.flutter.io/flutter/widgets/Container-class.html',
          },
        )
      ]),
];

const kMyAppRoutesAdvanced = <MyRouteGroup>[
];

final kAllRouteGroups = <MyRouteGroup>[
  ...kMyAppRoutesBasic,
...kMyAppRoutesAdvanced,
];

final kALlRoutes = <MyRoute>[
...kAllRouteGroups.expand((element) => element.routes)
];

final kRouteNameToRoute = <String, MyRoute>{
for (final route in kALlRoutes) route.routeName:route
};

final kRouteNameToRouteGroup= <String, MyRouteGroup> {
for (final group in kAllRouteGroups)
  for (final route in group.routes) route.routeName: group
};

final kAppRoutingTable = <String, WidgetBuilder>{
  Navigator.defaultRouteName: (context) {
    return kHomeRoute;
  },
  kAbouteRoute.routeName: (context) => kAbouteRoute,
  for (MyRoute route in kALlRoutes) route.routeName: (context) => route,
};
