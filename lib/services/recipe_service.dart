import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/recipe.dart';

class RecipeService {
  List<Recipe> _recipes = [];
  List<String> _classes = [];

  List<Recipe> get recipes => _recipes;
  List<String> get classes => _classes;

  Future<void> loadData() async {
    final recipesStr = await rootBundle.loadString('assets/data/recipes.json');
    final recipesJson = jsonDecode(recipesStr) as List<dynamic>;
    _recipes = recipesJson.map((e) => Recipe.fromJson(e as Map<String, dynamic>)).toList();

    final classesStr = await rootBundle.loadString('assets/data/classes.json');
    final classesJson = jsonDecode(classesStr) as List<dynamic>;
    _classes = classesJson
        .map((e) => e.toString())
        .where((c) => c.toLowerCase() != 'image_9')
        .toList();
  }

  List<Recipe> recommend(List<String> userIngredients, {double minScore = 0.6}) {
    final haveSet = userIngredients.map((e) => e.trim().toLowerCase()).toSet();
    final List<Recipe> results = [];

    for (final r in _recipes) {
      final ada = r.utama.where((b) => haveSet.contains(b.trim().toLowerCase())).toList();
      final kurang = r.utama.where((b) => !haveSet.contains(b.trim().toLowerCase())).toList();

      if (ada.isEmpty) continue;
      final skor = ada.length / (r.utama.isEmpty ? 1 : r.utama.length);
      if (skor < minScore - 1e-9) continue;

      results.add(r.copyWithMatch(skor: skor, ada: ada, kurang: kurang));
    }

    results.sort((a, b) {
      final cmpSkor = b.skor.compareTo(a.skor);
      if (cmpSkor != 0) return cmpSkor;
      final cmpKurang = a.kurang.length.compareTo(b.kurang.length);
      if (cmpKurang != 0) return cmpKurang;
      return a.nama.compareTo(b.nama);
    });

    return results;
  }
}
