import 'package:bloc_tutorial/model/movie_list_response.dart';
import 'package:equatable/equatable.dart';

abstract class MovieDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieDetailFetchEvent extends MovieDetailEvent {}

// class AddFavoriteEvent extends MovieDetailEvent {
//   AddFavoriteEvent({required this.movie});
//   final TvShows movie;
// }
