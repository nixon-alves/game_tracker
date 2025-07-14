class Game {
  final String title;
  final String image;
  final String? rating;
  final String status;
  final String? date;

  Game(this.title, this.image, this.rating, this.status, this.date,);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'image': image,
      'rating': rating,
      'status': status,
      'date': date,
    };
  }

  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      map['title'],
      map['image'],
      map['rating'],
      map['status'],
      map['date'],
    );
  }
}
