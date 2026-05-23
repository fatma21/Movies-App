import 'package:hive/hive.dart';

part 'movies_model.g.dart';

@HiveType(typeId: 0)
class MovieModel {

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final int year;

  @HiveField(3)
  final double rating;

  @HiveField(4)
  final int runtime;

  @HiveField(5)
  final String summary;

  @HiveField(6)
  final String mediumCoverImage;

  @HiveField(7)
  final String largeCoverImage;

  @HiveField(8)
  final String backgroundImage;

  @HiveField(9)
  final List<String> genres;

  @HiveField(10)
  final List<String>? screenshots;

  @HiveField(11)
  final List<CastModel>? cast;

  @HiveField(12)
  final String? ytTrailerCode;

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
    this.ytTrailerCode,
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
      largeCoverImage:
      json['large_cover_image'] ??
          json['medium_cover_image'] ??
          "",
      backgroundImage:
      json['background_image_original'] ?? "",
      genres:
      json['genres'] != null
          ? List<String>.from(json['genres'])
          : [],
      screenshots: [
        if (json['large_screenshot_image1'] != null)
          json['large_screenshot_image1'],

        if (json['large_screenshot_image2'] != null)
          json['large_screenshot_image2'],

        if (json['large_screenshot_image3'] != null)
          json['large_screenshot_image3'],
      ],
      cast:
      json['cast'] != null
          ? (json['cast'] as List)
          .map(
            (c) => CastModel.fromJson(c),
      )
          .toList()
          : null,
      ytTrailerCode:
      json['yt_trailer_code'] ?? "",
    );

  }
}

@HiveType(typeId: 1)
class CastModel {

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String characterName;

  @HiveField(2)
  final String? urlSmallImage;

  CastModel({
    required this.name,
    required this.characterName,
    this.urlSmallImage,
  });

  factory CastModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return CastModel(
      name: json['name'] ?? "",
      characterName:
      json['character_name'] ?? "",
      urlSmallImage:
      json['url_small_image'],
    );
  }
}