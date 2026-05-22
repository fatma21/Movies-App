import '../../../../core/models/movies_model.dart';
import '../data_source/explore_remote_data_source.dart';


class ExploreRepo {
  final ExploreRemoteDataSource _remoteDataSource;
  ExploreRepo(this._remoteDataSource);

  Future<List<MovieModel>> getMoviesByGenre(String genre, {int page = 1}) {
    return _remoteDataSource.getMoviesByGenre(genre,page: page);
  }
}