import 'package:flutter/material.dart';
import 'package:flutter_catalog/my_route.dart';
import 'package:provider/provider.dart';
import 'package:flutter_catalog/my_app_settings.dart';
import 'package:substring_highlight/substring_highlight.dart';
import 'my_app_routes.dart';

class MyRouteSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return <Widget>[
      if (this.query.isNotEmpty)
        IconButton(
          tooltip: 'Clear',
          icon: Icon(Icons.clear),
          onPressed: () => this.query = '',
        )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () => this.close(context, ''),
      icon: Icon(Icons.arrow_back),
      tooltip: 'Back',
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    Iterable<MyRoute> suggestions = [
      for (final routeName in Provider.of<MyAppSettings>(context).searchHistory)
        kRouteNameToRoute[routeName]!
    ];
    if (this.query.isNotEmpty) {
      suggestions = kALlRoutes
          .where(
            (route) =>
                route.title.toLowerCase().contains(query.toLowerCase()) ||
                route.description.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    return _buildSuggestionsList(suggestions);
  }

  Widget _buildSuggestionsList(Iterable<MyRoute> suggestions) {
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (BuildContext context, int i) {
          final route = suggestions.elementAt(i);
          final routeGroup = kRouteNameToRouteGroup[route.routeName]!;
          return ListTile(
            leading:
                query.isEmpty ? const Icon(Icons.history) : routeGroup.icon,
            title: SubstringHighlight(
              text: '${routeGroup.groupName}/${route.routeName}',
              term: query,
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            subtitle: route.description.isEmpty
                ? null
                : SubstringHighlight(
                    text: route.description,
                    term: query,
                    textStyle: Theme.of(context).textTheme.bodyText2!,
                  ),
            onTap: () {
              Provider.of<MyAppSettings>(context, listen: false)
                  .addSearchHistoty(route.routeName);
              Navigator.of(context).popAndPushNamed(route.routeName);
            },
            trailing: const Icon(Icons.keyboard_arrow_right),
          );
        });
  }
}
