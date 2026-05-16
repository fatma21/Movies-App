import '../../../../core/models/movies_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeSuccess extends HomeState {
  final List<MovieModel> recentlyAddedMovies;
  final List<MovieModel> genreMovies;
  final String selectedGenre;

  HomeSuccess({
    this.recentlyAddedMovies = const [],
    this.genreMovies = const [],
    this.selectedGenre = "Action",
  });

  HomeState copyWith({
    List<MovieModel>? recentlyAddedMovies,
    List<MovieModel>? genreMovies,
    String? selectedGenre,
  }) {
    return HomeSuccess(
      recentlyAddedMovies: recentlyAddedMovies ?? this.recentlyAddedMovies,
      genreMovies: genreMovies ?? this.genreMovies,
      selectedGenre: selectedGenre ?? this.selectedGenre,
    );
  }
}
class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
class HomeGenderError extends HomeState {
  final String message;
  HomeGenderError(this.message);
}