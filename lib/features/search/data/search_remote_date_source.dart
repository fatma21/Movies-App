import '../../../../core/network/api_service.dart';

class SearchRemoteDataSource {
  final ApiService _apiService;

  SearchRemoteDataSource(this._apiService);

  Future<Map<String, dynamic>> searchMovies(String query, {int page = 1}) async {
    return await _apiService.get(
      'list_movies.json',
      query: {
        'query_term': query,
        'page': page,
        'limit': 20,
      },
    );
  }
}