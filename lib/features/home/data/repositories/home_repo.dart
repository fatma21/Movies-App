import '../../../../core/models/movies_model.dart';
import '../data_source/home_local_data_source.dart';
import '../data_source/home_remote_data_source.dart';

class HomeRepo {

  final HomeRemoteDataSource _remoteDataSource;
  final HomeLocalDataSource _localDataSource;

  HomeRepo(
      this._remoteDataSource,
      this._localDataSource,
      );

  // RECENTLY ADDED

  Future<List<MovieModel>> getRecentlyAdded() async {

    try {

      final localMovies =
      _localDataSource.getRecentlyAdded();

      print(
        "LOCAL RECENTLY ADDED SIZE: ${localMovies.length}",
      );

      if (localMovies.isNotEmpty) {

        print("Returning RECENTLY ADDED from Hive");

        Future(() async {

          try {

            print(
              "Refreshing RECENTLY ADDED from API",
            );

            final remoteMovies =
            await _remoteDataSource
                .getRecentlyAdded();

            await _localDataSource
                .saveRecentlyAdded(remoteMovies);

            print(
              "RECENTLY ADDED updated in Hive",
            );

          } catch (e) {

            print(
              "Background refresh failed: $e",
            );
          }
        });

        return localMovies;
      }

      print(
        "No local RECENTLY ADDED found",
      );

      final remoteMovies =
      await _remoteDataSource
          .getRecentlyAdded();

      await _localDataSource
          .saveRecentlyAdded(remoteMovies);

      return remoteMovies;

    } catch (e) {

      print(
        "ERROR IN RECENTLY ADDED: $e",
      );

      final localMovies =
      _localDataSource.getRecentlyAdded();

      if (localMovies.isNotEmpty) {
        return localMovies;
      }

      rethrow;
    }
  }

  // GENRE MOVIES

  Future<List<MovieModel>> getMoviesByGenre(
      String genre,
      ) async {

    try {

      final localMovies =
      _localDataSource.getGenreMovies(genre);

      print(
        "LOCAL $genre SIZE: ${localMovies.length}",
      );

      if (localMovies.isNotEmpty) {

        print(
          "Returning $genre movies from Hive",
        );

        Future(() async {

          try {

            print(
              "Refreshing $genre movies from API",
            );

            final remoteMovies =
            await _remoteDataSource
                .getMoviesByGenre(genre);

            await _localDataSource
                .saveGenreMovies(
              genre,
              remoteMovies,
            );

            print(
              "$genre movies updated in Hive",
            );

          } catch (e) {

            print(
              "Background refresh failed: $e",
            );
          }
        });

        return localMovies;
      }

      print(
        "No local $genre movies found",
      );

      final remoteMovies =
      await _remoteDataSource
          .getMoviesByGenre(genre);

      await _localDataSource
          .saveGenreMovies(
        genre,
        remoteMovies,
      );

      return remoteMovies;

    } catch (e) {

      print(
        "ERROR IN $genre MOVIES: $e",
      );

      final localMovies =
      _localDataSource.getGenreMovies(genre);

      if (localMovies.isNotEmpty) {
        return localMovies;
      }

      rethrow;
    }
  }

  Future<MovieModel> getMovieDetails(
      int movieId,
      ) {

    return _remoteDataSource
        .getMovieDetails(movieId);
  }

  Future<List<MovieModel>> getSimilarMovies(
      int movieId,
      ) {

    return _remoteDataSource
        .getSimilarMovies(movieId);
  }

  Future<MovieModel> getMovieById(
      int id,
      ) {

    return _remoteDataSource
        .getMovieById(id);
  }
}