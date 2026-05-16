import '../../../../core/models/movies_model.dart';
import '../../../../core/network/api_service.dart';

class HomeRemoteDataSource {
  final ApiService _apiService;

  HomeRemoteDataSource(this._apiService);

  Future<List<MovieModel>> getRecentlyAdded() async {
    try {
      final data = await _apiService.get(
        'list_movies.json',
        query: {
          'sort_by': 'date_added',
          'order_by': 'desc',
          'limit': 10,
        },
      );

      if (data['status'] == 'ok') {
        final moviesJson = data['data']['movies'];

        if (moviesJson == null) {
          return [];
        }

        return List<MovieModel>.from(
          moviesJson.map((json) => MovieModel.fromJson(json)),
        );
      } else {
        throw Exception(data['status_message']);
      }
    } catch (e) {
      print("ERROR: $e");
      rethrow;
    }
  }

  Future<List<MovieModel>> getMoviesByGenre(String genre) async {
    try {
      final data = await _apiService.get(
        'list_movies.json',
        query: {
          'genre': genre,
          'limit': 20,
        },
      );

      if (data['status'] == 'ok') {
        final moviesJson = data['data']['movies'];

        if (moviesJson == null) {
          return [];
        }

        return List<MovieModel>.from(
          moviesJson.map((json) => MovieModel.fromJson(json)),
        );
      } else {
        throw Exception(data['status_message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<MovieModel> getMovieDetails(int movieId) async {
    try {
      final data = await _apiService.get(
        'movie_details.json',
        query: {
          'movie_id': movieId,
          'with_cast': true,
          'with_images': true,
        },
      );

      if (data['status'] == 'ok') {
        final movieJson = data['data']['movie'];

        return MovieModel.fromJson(movieJson);
      } else {
        throw Exception(data['status_message']);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MovieModel>> getSimilarMovies(int movieId) async {
    try {
      final data = await _apiService.get('movie_suggestions.json', query: {
        'movie_id': movieId,
      });

      if (data['status'] == 'ok') {
        // Check both possible keys: 'movies' and 'movie_suggestions'
        final List? moviesJson = data['data']['movies'] ?? data['data']['movie_suggestions'];

        if (moviesJson != null) {
          return moviesJson.map((json) => MovieModel.fromJson(json)).toList();
        }
      }
      return [];
    } catch (e) {
      return []; // Return empty list instead of crashing
    }
  }
}