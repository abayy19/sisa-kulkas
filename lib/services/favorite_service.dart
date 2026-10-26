import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  static const String _key = 'sisakulkas_favorites';

  static Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  static Future<bool> toggleFavorite(String recipeName) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    bool isNowFav;
    if (list.contains(recipeName)) {
      list.remove(recipeName);
      isNowFav = false;
    } else {
      list.add(recipeName);
      isNowFav = true;
    }
    await prefs.setStringList(_key, list);
    return isNowFav;
  }

  static Future<bool> isFavorite(String recipeName) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    return list.contains(recipeName);
  }
}
