import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/models/movies_model.dart';
import '../../data/repositories/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  static const List<String> genres = [
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
  List<MovieModel> cachedRecentlyAdded = [];
  List<MovieModel> cachedGenreMovies = [];


  HomeCubit(this._homeRepo) : super(HomeInitial());

  Future<void> fetchHomeMovies() async {
    emit(HomeLoading());

    try {
      final movies = await _homeRepo.getRecentlyAdded();
      cachedRecentlyAdded = await _homeRepo.getRecentlyAdded();
      emit(HomeSuccess(recentlyAddedMovies: movies, genreMovies: cachedGenreMovies));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> fetchChangingGenreMovies() async {
    emit(HomeLoading());

    try {
      final prefs = await SharedPreferences.getInstance();

      int currentIndex = prefs.getInt('genre_index') ?? 0;

      currentIndex++;

      if (currentIndex >= genres.length) {
        currentIndex = 0;
      }

      await prefs.setInt('genre_index', currentIndex);

      final selectedGenre = genres[currentIndex];

      final movies =
      await _homeRepo.getMoviesByGenre(selectedGenre);
      cachedGenreMovies = movies;

      emit(HomeSuccess(selectedGenre: selectedGenre, genreMovies: movies, recentlyAddedMovies: cachedRecentlyAdded));
    } catch (e) {
      emit(HomeGenderError(e.toString()));
    }
  }
}