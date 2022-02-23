import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_catalog/constants.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class MyAboutRoute extends StatelessWidget {
  static final kAboutTitles = [
    const ListTile(
      title: Text(APP_DESCRIPTION),
    ),
    const Divider(),
    ListTile(
      leading: const Icon(
        Icons.shop,
      ),
      title: const Text('Rate on Google Play'),
      onTap: () => url_launcher.launch(GOOGLEPLAY_URL),
    ),
    ListTile(
      leading: const Icon(Icons.bug_report),
      title: const Text('Report issue on GitHub'),
      onTap: () => url_launcher.launch('$GITHUB_URL/issues'),
    ),
    ListTile(
      leading: const Icon(Icons.open_in_new),
      title: const Text('Visit my website'),
      onTap: () => url_launcher.launch(AUTHOR_SITE),
    )
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final header = ListTile(
      leading: kAppIcon,
      title: const Text(APP_NAME),
      subtitle: const Text(APP_VERSION),
      trailing: IconButton(
        icon: const Icon(Icons.info),
        onPressed: () {
          showAboutDialog(
              applicationName: APP_NAME,
              applicationVersion: APP_VERSION,
              applicationIcon: kAppIcon,
              children: [const Text(APP_DESCRIPTION)],
              context: context);
        },
      ),
    );
    return ListView(children: [
      header,
...kAboutTitles,
    ],);
  }
}
