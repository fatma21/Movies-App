import 'package:hive/hive.dart';
import '../../../../core/models/movies_model.dart';

class ExploreLocalDataSource {
  final Box<List> box;

  ExploreLocalDataSource(this.box);

  String _key(String genre, int page) => "$genre-$page";

  List<MovieModel> getMovies(String genre, int page) {
    final data = box.get(_key(genre, page));
    if (data == null) return [];

    return List<MovieModel>.from(data);
  }

  Future<void> saveMovies(
      String genre,
      int page,
      List<MovieModel> movies,
      ) async {
    await box.put(_key(genre, page), movies);
  }
}