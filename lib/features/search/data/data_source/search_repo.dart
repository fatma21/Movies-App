import '../../../../core/models/movies_model.dart';
import '../search_remote_date_source.dart';

class SearchRepo {
  final SearchRemoteDataSource _remoteDataSource;

  SearchRepo(this._remoteDataSource);

  Future<List<MovieModel>> searchMovies(String query, {int page = 1}) async {
    final data = await _remoteDataSource.searchMovies(query, page: page);

    if (data['status'] == 'ok') {
      final moviesJson = data['data']['movies'];

      if (moviesJson == null || moviesJson is! List) {
        return [];
      }

      return List<MovieModel>.from(
        moviesJson.map((json) => MovieModel.fromJson(json)),
      );
    } else {
      throw Exception(data['status_message'] ?? 'Search failed');
    }
  }
}