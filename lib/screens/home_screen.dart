import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_theme.dart';
import '../providers/fridge_provider.dart';
import 'favorite_screen.dart';
import 'recipe_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FridgeProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.fridge,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SisaKulkas',
              style: TextStyle(
                color: AppTheme.ink,
                fontWeight: FontWeight.w900,
                fontSize: 22,
                letterSpacing: -0.5,
              ),
            ),
            Text(
              'YOLOv8 Mobile Assistant',
              style: TextStyle(color: AppTheme.mute, fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.favorite, color: AppTheme.chili, size: 28),
                if (provider.favorites.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: AppTheme.butter,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${provider.favorites.length}',
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.ink,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoriteScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.pandan))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildDoorDropCard(context, provider),
                  const SizedBox(height: 18),
                  _buildShelfIngredientsCard(context, provider),
                  const SizedBox(height: 18),
                  _buildSettingsCard(context, provider),
                  const SizedBox(height: 24),
                  _buildRecipesSection(context, provider),
                ],
              ),
            ),
    );
  }

  Widget _buildDoorDropCard(BuildContext context, FridgeProvider provider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppTheme.ink, width: 2),
        boxShadow: const [
          BoxShadow(color: AppTheme.ink, offset: Offset(4, 4)),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppTheme.fridge,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.ink, width: 1.5, style: BorderStyle.solid),
            ),
            child: Column(
              children: [
                const Icon(Icons.kitchen_outlined, size: 54, color: AppTheme.pandan),
                const SizedBox(height: 8),
                const Text(
                  'Foto Isi Kulkasmu',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.ink,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Deteksi bahan otomatis dengan model YOLOv8 secara offline di perangkatmu.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppTheme.mute, fontSize: 13),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.chili,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                          side: const BorderSide(color: AppTheme.ink, width: 2),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Pilih Foto', style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        // Demo deteksi cepat bahan makanan
                        provider.setIngredientsFromDetection(['Telur', 'Bawang Merah', 'Cabe', 'Tomat']);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Foto diproses! Bahan terdeteksi: Telur, Bawang Merah, Cabe, Tomat'),
                            backgroundColor: AppTheme.pandan,
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.ink,
                        backgroundColor: AppTheme.paper,
                        side: const BorderSide(color: AppTheme.ink, width: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      ),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Ambil Foto', style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        provider.setIngredientsFromDetection(['Ayam', 'Kentang', 'Bawang Putih', 'Wortel']);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Foto diambil! Bahan terdeteksi: Ayam, Kentang, Bawang Putih, Wortel'),
                            backgroundColor: AppTheme.pandan,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShelfIngredientsCard(BuildContext context, FridgeProvider provider) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppTheme.ink, width: 2),
        boxShadow: const [
          BoxShadow(color: AppTheme.ink, offset: Offset(3, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Bahan Yang Kamu Punya',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppTheme.ink),
              ),
              Text(
                '${provider.userIngredients.length} bahan',
                style: const TextStyle(color: AppTheme.mute, fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Hapus bahan yang keliru atau tambahkan bahan yang terlewat.',
            style: TextStyle(color: AppTheme.mute, fontSize: 12),
          ),
          const SizedBox(height: 12),
          if (provider.userIngredients.isEmpty)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.fridge,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text('Belum ada bahan. Foto kulkas atau pilih bahan di bawah.',
                    style: TextStyle(color: AppTheme.mute, fontSize: 13)),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: provider.userIngredients.map((b) {
                return Chip(
                  backgroundColor: AppTheme.butter,
                  side: const BorderSide(color: AppTheme.ink, width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  label: Text(
                    b,
                    style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.ink),
                  ),
                  deleteIcon: const Icon(Icons.close, size: 16, color: AppTheme.ink),
                  onDeleted: () => provider.removeIngredient(b),
                );
              }).toList(),
            ),
          const SizedBox(height: 14),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              labelText: '+ Tambah Bahan Lain',
              labelStyle: const TextStyle(color: AppTheme.ink, fontWeight: FontWeight.w600),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppTheme.ink, width: 1.5),
              ),
            ),
            items: provider.allClasses.map((item) {
              return DropdownMenuItem(value: item, child: Text(item));
            }).toList(),
            onChanged: (val) {
              if (val != null) provider.addIngredient(val);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard(BuildContext context, FridgeProvider provider) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.paper,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppTheme.ink, width: 1.5),
      ),
      child: ExpansionTile(
        title: const Text('Pengaturan Ambang Deteksi & Resep',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppTheme.ink)),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Ambang Keyakinan YOLO:'),
              Text('${(provider.confThreshold * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Slider(
            value: provider.confThreshold,
            min: 0.1,
            max: 0.9,
            divisions: 8,
            activeColor: AppTheme.chili,
            onChanged: (v) => provider.setConfThreshold(v),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Kecocokan Minimal Resep:'),
              Text('${(provider.minScore * 100).toInt()}%', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Slider(
            value: provider.minScore,
            min: 0.3,
            max: 1.0,
            divisions: 7,
            activeColor: AppTheme.pandan,
            onChanged: (v) => provider.setMinScore(v),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipesSection(BuildContext context, FridgeProvider provider) {
    final list = provider.recommendedRecipes;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Masakan Untukmu',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppTheme.ink),
            ),
            Text(
              '${list.length} rekomendasi',
              style: const TextStyle(color: AppTheme.pandan, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (list.isEmpty)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.paper,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.ink, width: 1.5),
            ),
            child: const Center(
              child: Text(
                'Belum ada resep yang cocok. Tambahkan lebih banyak bahan kulkas di atas!',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppTheme.mute),
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final r = list[i];
              final isFav = provider.favorites.contains(r.nama);
              final pct = (r.skor * 100).round();

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RecipeDetailScreen(recipe: r)),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.paper,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppTheme.ink, width: 2),
                    boxShadow: const [
                      BoxShadow(color: AppTheme.ink, offset: Offset(3, 3)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              r.nama,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.ink,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: pct >= 80 ? AppTheme.pandan : AppTheme.butter,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppTheme.ink, width: 1.5),
                            ),
                            child: Text(
                              '$pct% Cocok',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: pct >= 80 ? Colors.white : AppTheme.ink,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? AppTheme.chili : AppTheme.mute,
                            ),
                            onPressed: () => provider.toggleFavorite(r.nama),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Bahan ada: ${r.ada.join(", ")}',
                        style: const TextStyle(color: AppTheme.pandan, fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      if (r.kurang.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          'Kurang: ${r.kurang.join(", ")}',
                          style: const TextStyle(color: AppTheme.chiliDark, fontSize: 13),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
