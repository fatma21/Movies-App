import '../../../../core/models/movies_model.dart';

abstract class ExploreState {}

class ExploreInitial extends ExploreState {}

class ExploreLoading extends ExploreState {}

class ExploreSuccess extends ExploreState {
  final List<MovieModel> movies;
  final int selectedIndex;

  ExploreSuccess({
    required this.movies,
    required this.selectedIndex,
  });
}

class ExploreError extends ExploreState {
  final String message;

  ExploreError(this.message);
}