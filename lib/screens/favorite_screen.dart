import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_theme.dart';
import '../providers/fridge_provider.dart';
import 'recipe_detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FridgeProvider>();
    final allRecipes = provider.recommendedRecipes.isNotEmpty
        ? provider.recommendedRecipes
        : [];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.fridge,
        elevation: 0,
        title: const Text(
          'Resep Favorit',
          style: TextStyle(fontWeight: FontWeight.w800, color: AppTheme.ink),
        ),
      ),
      body: provider.favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.favorite_border, size: 60, color: AppTheme.mute),
                  SizedBox(height: 12),
                  Text(
                    'Belum ada resep favorit',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.ink),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Ketuk ikon hati pada resep untuk menyimpannya di sini.',
                    style: TextStyle(color: AppTheme.mute, fontSize: 13),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: provider.favorites.map((nama) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: AppTheme.ink, width: 1.5),
                  ),
                  child: ListTile(
                    title: Text(nama, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: const Text('Tersimpan di favorit lokal HP'),
                    trailing: IconButton(
                      icon: const Icon(Icons.favorite, color: AppTheme.chili),
                      onPressed: () => provider.toggleFavorite(nama),
                    ),
                  ),
                );
              }).toList(),
            ),
    );
  }
}
