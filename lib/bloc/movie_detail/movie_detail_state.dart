import 'package:bloc_tutorial/model/movie_detail_response.dart';
import 'package:bloc_tutorial/model/movie_list_response.dart';
import 'package:bloc_tutorial/util/api_response.dart';
import 'package:equatable/equatable.dart';

class MovieDetailState extends Equatable {
  final ApiResponse<TVShowDetailResponse> tvShow;
  final List<TvShows> favoriteList;

  const MovieDetailState({required this.tvShow, this.favoriteList = const []});

  MovieDetailState copyWith(
      {ApiResponse<TVShowDetailResponse>? tvShow,
      List<TvShows>? favoriteList}) {
    return MovieDetailState(
        tvShow: tvShow ?? this.tvShow,
        favoriteList: favoriteList ?? this.favoriteList);
  }

  @override
  List<Object?> get props => [tvShow, favoriteList];
}
