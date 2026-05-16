import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/movies_detials/presentation/managers/details_states.dart';
import '../../../home/data/repositories/home_repo.dart';
import '../../../../core/models/movies_model.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final HomeRepo _repo;

  DetailsCubit(this._repo) : super(DetailsInitial());

  // Update your function to accept the movie you already have
  Future<void> fetchMovieDetails(int movieId) async {
    emit(DetailsLoading());

    try {
      final movie = await _repo.getMovieDetails(movieId);

      final similar = await _repo.getSimilarMovies(movieId);

      emit(
        DetailsSuccess(
          movie: movie,
          similarMovies: similar,
        ),
      );
    } catch (e) {
      emit(DetailsError(e.toString()));
    }
  }
}