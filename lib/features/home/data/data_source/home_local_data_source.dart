import 'package:hive/hive.dart';

import '../../../../core/models/movies_model.dart';

class HomeLocalDataSource {

  final Box movieBox =
  Hive.box('moviesBox');

  Future<void> saveRecentlyAdded(
      List<MovieModel> movies,
      ) async {

    await movieBox.put(
      'recently_added',
      movies,
    );
  }

  List<MovieModel> getRecentlyAdded() {

    return (
        movieBox.get(
          'recently_added',
          defaultValue: [],
        ) as List
    ).cast<MovieModel>();
  }


  Future<void> saveGenreMovies(
      String genre,
      List<MovieModel> movies,
      ) async {

    await movieBox.put(
      'genre_$genre',
      movies,
    );
  }

  List<MovieModel> getGenreMovies(
      String genre,
      ) {

    return (
        movieBox.get(
          'genre_$genre',
          defaultValue: [],
        ) as List
    ).cast<MovieModel>();
  }
}