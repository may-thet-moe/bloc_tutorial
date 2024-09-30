import 'package:bloc_tutorial/model/movie_list_response.dart';
import 'package:equatable/equatable.dart';

abstract class FavouriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddFavouriteEvent extends FavouriteEvent {
  AddFavouriteEvent({required this.movie});
  final TvShows movie;
}
