# SisaKulkas - Flutter Mobile App

Sistem Rekomendasi Resep Makanan Cerdas Berbasis Computer Vision (YOLOv8).

## Fitur Utama
- **Scan & Deteksi Bahan Makanan**: Deteksi bahan makanan sisa kulkas menggunakan model YOLOv8 secara on-device.
- **Katalog Resep Cerdas**: 27 resep masakan Indonesia dengan kalkulasi kecocokan bahan secara realtime.
- **Daftar Bahan Fleksibel (Shelf)**: Tambah atau hapus bahan makanan secara manual.
- **Fitur Favorit**: Simpan resep favorit ke penyimpanan lokal perangkat (SharedPreferences).
- **Pengaturan Ambang**: Konfigurasi tingkat keyakinan (confidence) dan minimal skor kecocokan resep.

## Struktur Direktori
```
lib/
├── config/app_theme.dart          # Tema warna retro neo-brutalism
├── models/
│   ├── recipe.dart                # Model data resep masakan
│   └── detection_item.dart        # Model hasil deteksi YOLOv8
├── services/
│   ├── recipe_service.dart        # Logika rekomendasi & pencocokan bahan
│   └── favorite_service.dart      # Manajemen penyimpanan favorit
├── providers/
│   └── fridge_provider.dart       # State management (Provider)
├── screens/
│   ├── home_screen.dart           # Halaman utama (Drop, Shelf, Rekomendasi)
│   ├── recipe_detail_screen.dart  # Detail bahan & cara memasak
│   └── favorite_screen.dart       # Halaman resep favorit pengguna
└── main.dart                      # Entry point Flutter
assets/
├── data/recipes.json              # 27 database resep masakan Indonesia
├── data/classes.json              # 25 kelas bahan makanan
└── model/best.onnx                # Model deteksi YOLOv8
```
