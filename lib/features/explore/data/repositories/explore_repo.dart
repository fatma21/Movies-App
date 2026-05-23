import '../../../../core/models/movies_model.dart';
import '../data_source/explore_remote_data_source.dart';
import '../data_source/explore_local_data_source.dart';

class ExploreRepo {
  final ExploreRemoteDataSource _remote;
  final ExploreLocalDataSource _local;

  ExploreRepo(this._remote, this._local);

  Future<List<MovieModel>> getMoviesByGenre(
      String genre, {
        int page = 1,
      }) async {
    try {
      final local = _local.getMovies(genre, page);

      if (local.isNotEmpty) {
        Future(() async {
          try {
            final remote = await _remote.getMoviesByGenre(
              genre,
              page: page,
            );

            await _local.saveMovies(genre, page, remote);
          } catch (_) {}
        });

        return local;
      }

      final remote = await _remote.getMoviesByGenre(
        genre,
        page: page,
      );

      await _local.saveMovies(genre, page, remote);

      return remote;
    } catch (e) {
      final local = _local.getMovies(genre, page);

      if (local.isNotEmpty) return local;

      rethrow;
    }
  }
}