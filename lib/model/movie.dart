class Movie {
  final String primaryImage;
  final String titleText;
  final dynamic releaseYear;

  Movie({
    required this.primaryImage,
    required this.titleText,
    required this.releaseYear,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      primaryImage: json['primaryImage'] as String,
      titleText: json['titleText'] as String,
       releaseYear: json['releaseYear'],
    );
  }
}
