import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/recipe_service.dart';
import '../services/favorite_service.dart';

class FridgeProvider extends ChangeNotifier {
  final RecipeService _recipeService = RecipeService();

  List<String> _userIngredients = [];
  List<Recipe> _recommendedRecipes = [];
  Set<String> _favorites = {};
  double _confThreshold = 0.4;
  double _minScore = 0.6;
  bool _isLoading = false;

  List<String> get userIngredients => _userIngredients;
  List<Recipe> get recommendedRecipes => _recommendedRecipes;
  List<String> get allClasses => _recipeService.classes;
  Set<String> get favorites => _favorites;
  double get confThreshold => _confThreshold;
  double get minScore => _minScore;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    _isLoading = true;
    notifyListeners();
    await _recipeService.loadData();
    final favList = await FavoriteService.getFavorites();
    _favorites = favList.toSet();
    _isLoading = false;
    notifyListeners();
  }

  void addIngredient(String name) {
    final clean = name.trim();
    if (clean.isEmpty) return;
    final exists = _userIngredients.any((e) => e.toLowerCase() == clean.toLowerCase());
    if (!exists) {
      _userIngredients.add(clean);
      _recalculate();
      notifyListeners();
    }
  }

  void removeIngredient(String name) {
    _userIngredients.removeWhere((e) => e.toLowerCase() == name.toLowerCase());
    _recalculate();
    notifyListeners();
  }

  void setIngredientsFromDetection(List<String> detected) {
    _userIngredients = detected;
    _recalculate();
    notifyListeners();
  }

  void setMinScore(double val) {
    _minScore = val;
    _recalculate();
    notifyListeners();
  }

  void setConfThreshold(double val) {
    _confThreshold = val;
    notifyListeners();
  }

  void _recalculate() {
    _recommendedRecipes = _recipeService.recommend(_userIngredients, minScore: _minScore);
  }

  Future<void> toggleFavorite(String recipeName) async {
    final isFav = await FavoriteService.toggleFavorite(recipeName);
    if (isFav) {
      _favorites.add(recipeName);
    } else {
      _favorites.remove(recipeName);
    }
    notifyListeners();
  }
}
