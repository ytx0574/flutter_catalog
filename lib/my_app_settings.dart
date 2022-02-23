import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppSettings extends ChangeNotifier {
  static const _kDarkModePreferenceKey = 'DARK_MODE';
  static const _kSearchHistoryPreferenceKey = 'SEARCH_HISTORY';

  static const _kBookmarkedRoutesPreferenceKey = 'BOOKMARKED_ROUTES';

  static Future<MyAppSettings> create() async {
    final sharePref = await SharedPreferences.getInstance();
    final s = MyAppSettings._(sharePref);
    // await s._init();
    return s;
  }

  final SharedPreferences _pref;

  MyAppSettings._(this._pref);

  List<String> get starredRoutenames =>
      _pref.getStringList(_kBookmarkedRoutesPreferenceKey) ?? [];

  bool isStarred(String routeName) => starredRoutenames.contains(routeName);

  void toggleStarred(String routeName) {
    final sharedRoutes = this.starredRoutenames;
    if (isStarred(routeName)) {
      sharedRoutes.remove(routeName);
    } else {
      sharedRoutes.add(routeName);
    }
    final dequedStaredRoutes = Set<String>.from(sharedRoutes).toList();
    _pref.setStringList(_kBookmarkedRoutesPreferenceKey, dequedStaredRoutes);
    notifyListeners();
  }

  bool get isDarkMode => _pref.getBool(_kDarkModePreferenceKey) ?? false;

  void setDarkMode(bool val) {
    _pref.setBool(_kDarkModePreferenceKey, val);
    notifyListeners();
  }

  List<String> get searchHistory =>
      _pref.getStringList(_kSearchHistoryPreferenceKey) ?? [];

  void addSearchHistoty(String routeName) {
    List<String> history = this.searchHistory;
    history.remove(routeName);
    history.insert(0, routeName);
    if (history.length >= 10) {
      history = history.take(10).toList();
    }
    _pref.setStringList(_kSearchHistoryPreferenceKey, history);
  }

  Widget starStatusOfRoute(String routeName) {
    return IconButton(
        onPressed: () => this.toggleStarred,
        icon: Icon(this.isStarred(routeName) ? Icons.star : Icons.star_border,
            color: this.isStarred(routeName) ? Colors.yellow : Colors.grey));
  }
}
