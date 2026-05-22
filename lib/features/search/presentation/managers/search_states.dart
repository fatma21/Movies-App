import '../../../../core/models/movies_model.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<MovieModel> movies;
  SearchSuccess({required this.movies});
}

class SearchEmpty extends SearchState {}

class SearchError extends SearchState {
  final String message;
  SearchError(this.message);
}