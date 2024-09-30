import 'package:bloc_tutorial/bloc/favourite/favourite_event.dart';
import 'package:bloc_tutorial/bloc/favourite/favourite_state.dart';
import 'package:bloc_tutorial/model/movie_list_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(const FavouriteState()) {
    on<AddFavouriteEvent>(_addFavourite);
  }

  void _addFavourite(AddFavouriteEvent event, Emitter<FavouriteState> emit) {
    final newFavoriteList = List<TvShows>.from(state.favouriteList);
    if (newFavoriteList
            .where((element) => element.id == event.movie.id)
            .firstOrNull ==
        null) {
      newFavoriteList.add(event.movie);
    } else {
      newFavoriteList.removeWhere((element) => element.id == event.movie.id);
    }
    emit(state.copyWith(favoriteList: newFavoriteList));
  }
}
