import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/explore/presentation/mangers/explore_states.dart';
import '../../../../core/models/movies_model.dart';
import '../../data/repositories/explore_repo.dart';

class ExploreCubit extends Cubit<ExploreState> {
  final ExploreRepo repo;

  ExploreCubit(this.repo) : super(ExploreInitial());

  final List<String> genres = [
    "Action",
    "Adventure",
    "Animation",
    "Biography",
    "Comedy",
    "Crime",
    "Documentary",
    "Drama",
    "Family",
    "Fantasy",
    "Film-Noir",
    "History",
    "Horror",
    "Music",
    "Musical",
    "Mystery",
    "Romance",
    "Sci-Fi",
    "Sport",
    "Thriller",
    "War",
    "Western",
  ];

  int selectedIndex = 0;

  int _page = 1;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  List<MovieModel> movies = [];

  Future<void> fetchMoviesByGenre({int? index, bool reset = true}) async {
    if (index != null) selectedIndex = index;

    if (reset) {
      _page = 1;
      _hasMore = true;
      movies = [];
      emit(ExploreLoading());
    }

    try {
      final selectedGenre = genres[selectedIndex];

      final result = await repo.getMoviesByGenre(
        selectedGenre,
        page: _page,
      );

      movies = result;

      emit(
        ExploreSuccess(
          movies: movies,
          selectedIndex: selectedIndex,
        ),
      );
    } catch (e) {
      emit(ExploreError(e.toString()));
    }
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;

    try {
      _page++;

      final selectedGenre = genres[selectedIndex];

      final result = await repo.getMoviesByGenre(
        selectedGenre,
        page: _page,
      );

      if (result.isEmpty) {
        _hasMore = false;
      } else {
        movies.addAll(result);
      }

      emit(
        ExploreSuccess(
          movies: movies,
          selectedIndex: selectedIndex,
        ),
      );
    } catch (e) {
      emit(ExploreError(e.toString()));
    }

    _isLoadingMore = false;
  }
}