import '../../../../core/models/movies_model.dart';

abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsSuccess extends DetailsState {
  final MovieModel movie;
  final List<MovieModel> similarMovies;

  DetailsSuccess({required this.movie, required this.similarMovies});
}

class DetailsError extends DetailsState {
  final String message;
  DetailsError(this.message);
}