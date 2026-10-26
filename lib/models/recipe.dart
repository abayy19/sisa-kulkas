class Recipe {
  final String nama;
  final List<String> utama;
  final List<String> opsional;
  final String pantry;
  final List<String> langkah;

  double skor;
  List<String> ada;
  List<String> kurang;

  Recipe({
    required this.nama,
    required this.utama,
    required this.opsional,
    required this.pantry,
    required this.langkah,
    this.skor = 0.0,
    this.ada = const [],
    this.kurang = const [],
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      nama: json['nama'] as String? ?? '',
      utama: (json['utama'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      opsional: (json['opsional'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      pantry: json['pantry'] as String? ?? '',
      langkah: (json['langkah'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }

  Recipe copyWithMatch({
    required double skor,
    required List<String> ada,
    required List<String> kurang,
  }) {
    return Recipe(
      nama: nama,
      utama: utama,
      opsional: opsional,
      pantry: pantry,
      langkah: langkah,
      skor: skor,
      ada: ada,
      kurang: kurang,
    );
  }
}
