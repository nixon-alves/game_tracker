class GameSearchResult {
  final String title;
  final String image;
  final int year;
  final String company;

  GameSearchResult({
    required this.title,
    required this.image,
    required this.year,
    required this.company
  });

  factory GameSearchResult.fromMap(Map<String, dynamic> map) {
    return GameSearchResult(
      title: map['title'] ?? 'Sem título',
      image: map['image'] ?? '',
      year: map['year'] ?? 0,
      company: map['company'] ?? 'Desconhecida',
    );
  }
}
