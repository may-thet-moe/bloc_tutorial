import 'dart:developer';

import 'package:bloc_tutorial/bloc/movie_bloc/movie_event.dart';
import 'package:bloc_tutorial/bloc/movie_bloc/movie_state.dart';
import 'package:bloc_tutorial/model/movie_list_response.dart';
import 'package:bloc_tutorial/repository/movie_repository.dart';
import 'package:bloc_tutorial/util/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState>{
  MovieRepository repository = MovieRepository();
  int page = 1;
  MovieListResponse movieList = MovieListResponse();

  MovieBloc({required this.repository}): super(MovieState(movieList: ApiResponse.loading())){
    on<MovieFetchEvent>(_fetchMovieList);
  }

  void _fetchMovieList(MovieFetchEvent event, Emitter<MovieState> emit) async{
    bool isInitial = page == 1;
    await repository.fetchMovieList(page).then((value){
      page = value.page! + 1;
      if(isInitial){
        movieList = MovieListResponse(
          tvShows: value.tvShows, 
          page: value.page, 
          pages: value.pages,
          total: value.total);
        if(movieList.tvShows?.isEmpty == true){
          emit(state.copyWith(movieList: ApiResponse.complete(movieList)));
        }
       
      }else {
        movieList = MovieListResponse(
          tvShows: (movieList.tvShows ?? []) + (value.tvShows ?? []), 
          total: value.total, 
          page: value.page, 
          pages: value.pages);
      }
      emit(state.copyWith(movieList: ApiResponse.complete(movieList)));
    }).onError((error, stackTrace){
      emit(state.copyWith(movieList: ApiResponse.error(error.toString())));
    });
  }

  
}