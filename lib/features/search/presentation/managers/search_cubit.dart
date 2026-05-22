import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/movies_model.dart';
import '../../data/data_source/search_repo.dart';
import 'search_states.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo searchRepo;
  SearchCubit(this.searchRepo) : super(SearchInitial());

  Timer? _debounce;
  String _currentQuery = '';
  int _page = 1;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  List<MovieModel> movies = [];

  void onSearchChanged(String query) {
    _currentQuery = query;

    if (query.trim().isEmpty || query.trim().length < 2) {
      _debounce?.cancel();
      movies = [];
      emit(SearchInitial());
      return;
    }

    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 800), () {
      fetchSearchResults(query: query, reset: true);
    });
  }

  Future<void> fetchSearchResults({required String query, bool reset = true}) async {
    if (reset) {
      _page = 1;
      _hasMore = true;
      movies = [];
      emit(SearchLoading());
    }

    try {
      final result = await searchRepo.searchMovies(query, page: _page);

      movies = result;

      if (movies.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(SearchSuccess(movies: movies));
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    }
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore || _currentQuery.isEmpty) return;

    _isLoadingMore = true;
    try {
      _page++;
      final result = await searchRepo.searchMovies(_currentQuery, page: _page);

      if (result.isEmpty) {
        _hasMore = false;
      } else {
        movies.addAll(result);
        emit(SearchSuccess(movies: movies));
      }
    } catch (e) {
      emit(SearchError(e.toString()));
    }
    _isLoadingMore = false;
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}