import '../../../../core/models/movies_model.dart';
import '../../../../core/network/api_service.dart';

class ExploreRemoteDataSource {
  final ApiService _apiService;

  ExploreRemoteDataSource(this._apiService);

  Future<List<MovieModel>> getMoviesByGenre(
      String genre, {
        int page = 1,
      }) async {
    try {
      final data = await _apiService.get(
        'list_movies.json',
        query: {
          'genre': genre,
          'page': page,
          'limit': 20,
        },
      );

      if (data['status'] == 'ok') {

        final moviesJson = data['data']['movies'];

        if (moviesJson == null || moviesJson is! List) {
          return [];
        }

        return List<MovieModel>.from(
          moviesJson.map(
                (json) => MovieModel.fromJson(json),
          ),
        );

      } else {
        throw Exception(data['status_message']);
      }

    } catch (e) {
      rethrow;
    }
  }
}