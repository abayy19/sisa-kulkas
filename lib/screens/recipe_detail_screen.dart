import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_theme.dart';
import '../models/recipe.dart';
import '../providers/fridge_provider.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FridgeProvider>();
    final isFav = provider.favorites.contains(recipe.nama);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.fridge,
        elevation: 0,
        title: Text(
          recipe.nama,
          style: const TextStyle(fontWeight: FontWeight.w800, color: AppTheme.ink),
        ),
        actions: [
          IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: AppTheme.chili),
            onPressed: () => provider.toggleFavorite(recipe.nama),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.butter,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.ink, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Bahan Utama:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 6),
                  Text(recipe.utama.join(', '), style: const TextStyle(color: AppTheme.ink)),
                  if (recipe.opsional.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    const Text('Bahan Opsional:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text(recipe.opsional.join(', '), style: const TextStyle(color: AppTheme.mute)),
                  ],
                  if (recipe.pantry.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    const Text('Bumbu Dapur (Pantry):', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 4),
                    Text(recipe.pantry, style: const TextStyle(color: AppTheme.pandan)),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Langkah Memasak',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.ink),
            ),
            const SizedBox(height: 12),
            ...recipe.langkah.asMap().entries.map((e) {
              final idx = e.key + 1;
              final text = e.value;
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppTheme.paper,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.ink, width: 1.5),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: AppTheme.chili,
                      child: Text('$idx', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Text(text, style: const TextStyle(color: AppTheme.ink, height: 1.4))),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
