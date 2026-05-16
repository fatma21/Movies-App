class MovieModel {
  final int id;
  final String title;
  final int year;
  final double rating;
  final int runtime;
  final String summary;
  final String mediumCoverImage;
  final String largeCoverImage;
  final String backgroundImage;
  final List<String> genres;
  final List<String>? screenshots;
  final List<CastModel>? cast;

  MovieModel({
    required this.id,
    required this.title,
    required this.year,
    required this.rating,
    required this.runtime,
    required this.summary,
    required this.mediumCoverImage,
    required this.largeCoverImage,
    required this.backgroundImage,
    required this.genres,
    this.screenshots,
    this.cast,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? "Unknown",
      year: json['year'] ?? 0,
      rating: (json['rating'] ?? 0.0).toDouble(),
      runtime: json['runtime'] ?? 0,
      summary: json['description_full'] ?? "",
      mediumCoverImage: json['medium_cover_image'] ?? "",
      largeCoverImage: json['large_cover_image'] ?? json['medium_cover_image'] ??
      "",
      backgroundImage: json['background_image_original'] ?? "",
      genres: json['genres'] != null ? List<String>.from(json['genres']) : [],
      screenshots: [
        if (json['large_screenshot_image1'] != null) json['large_screenshot_image1'],
        if (json['large_screenshot_image2'] != null) json['large_screenshot_image2'],
        if (json['large_screenshot_image3'] != null) json['large_screenshot_image3'],
      ],
      cast: json['cast'] != null
          ? (json['cast'] as List).map((c) => CastModel.fromJson(c)).toList()
          : null,
    );
  }
}

class CastModel {
  final String name;
  final String characterName;
  final String? urlSmallImage;

  CastModel({required this.name, required this.characterName, this.urlSmallImage});

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      name: json['name'] ?? "",
      characterName: json['character_name'] ?? "",
      urlSmallImage: json['url_small_image'],
    );
  }
}
