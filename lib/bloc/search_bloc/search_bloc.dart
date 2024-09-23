import 'package:bloc_tutorial/bloc/search_bloc/search_event.dart';
import 'package:bloc_tutorial/bloc/search_bloc/search_state.dart';
import 'package:bloc_tutorial/model/movie_list_response.dart';
import 'package:bloc_tutorial/repository/movie_repository.dart';
import 'package:bloc_tutorial/util/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  MovieRepository repository = MovieRepository();

  SearchBloc(this.repository) : super(const SearchState()) {
    on<SearchResultEvent>(_searchFetch);
  }

  void _searchFetch(SearchResultEvent event, Emitter<SearchState> emit) async {
    await repository.getSearchResult(event.searchKey).then((value) {
      emit(state.copyWith(
          status: Status.complete,
          successOrFailure: 'Success',
          movieList: value));
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          status: Status.error, successOrFailure: error.toString()));
    });
  }
}
