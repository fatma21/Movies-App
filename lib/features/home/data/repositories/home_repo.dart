import '../../../../core/models/movies_model.dart';
import '../data_source/home_remote_data_source.dart';

class HomeRepo {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepo(this._remoteDataSource);

  Future<List<MovieModel>> getRecentlyAdded() async {
    try {
      return await _remoteDataSource.getRecentlyAdded();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<MovieModel>> getMoviesByGenre(String genre) {
    return _remoteDataSource.getMoviesByGenre(genre);
  }

  Future<MovieModel> getMovieDetails(int movieId) {
    return _remoteDataSource.getMovieDetails(movieId);
  }

  Future<List<MovieModel>> getSimilarMovies(int movieId) {
    return _remoteDataSource.getSimilarMovies(movieId);
  }

  Future<MovieModel> getMovieById(int id) {
    return _remoteDataSource.getMovieById(id);
  }

}