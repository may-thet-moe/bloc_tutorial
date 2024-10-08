import 'dart:developer';

import 'package:bloc_tutorial/bloc/movie_detail/movie_detail_event.dart';
import 'package:bloc_tutorial/bloc/movie_detail/movie_detail_state.dart';
import 'package:bloc_tutorial/model/movie_list_response.dart';
import 'package:bloc_tutorial/repository/movie_repository.dart';
import 'package:bloc_tutorial/util/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieRepository repository = MovieRepository();
  String movieName;
  MovieDetailBloc({required this.repository, required this.movieName})
      : super(MovieDetailState(tvShow: ApiResponse.loading())) {
    on<MovieDetailFetchEvent>(_fetchMovieDetail);
    // on<AddFavoriteEvent>(_addFavorite);
  }

  void _fetchMovieDetail(
      MovieDetailFetchEvent event, Emitter<MovieDetailState> emit) async {
    await repository.movieDetail(movieName: movieName).then((value) {
      emit(state.copyWith(tvShow: ApiResponse.complete(value)));
    }).onError((error, stackTrace) {
      emit(state.copyWith(tvShow: ApiResponse.error(error.toString())));
    });
  }

  // void _addFavorite(AddFavoriteEvent event, Emitter<MovieDetailState> emit) {
  //   final newFavoriteList = List<TvShows>.from(state.favoriteList);

  //   if (newFavoriteList
  //           .where((element) => element.id == event.movie.id)
  //           .firstOrNull ==
  //       null) {
  //     log('added');
  //     newFavoriteList.add(event.movie);
  //   } else {
  //     log('remove');
  //     newFavoriteList.removeWhere((element) => element.id == event.movie.id);
  //   }
  //   log('${newFavoriteList.length} - length');

  //   emit(state.copyWith(favoriteList: List<TvShows>.from(newFavoriteList)));
  // }
}
