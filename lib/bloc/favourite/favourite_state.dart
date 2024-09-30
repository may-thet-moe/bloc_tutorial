import 'package:bloc_tutorial/model/movie_list_response.dart';
import 'package:equatable/equatable.dart';

class FavouriteState extends Equatable {
  const FavouriteState({this.favouriteList = const []});

  final List<TvShows> favouriteList;

  FavouriteState copyWith({List<TvShows>? favoriteList}) {
    return FavouriteState(favouriteList: favoriteList ?? this.favouriteList);
  }

  @override
  List<Object?> get props => [favouriteList];
}
