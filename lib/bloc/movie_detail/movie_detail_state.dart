import 'package:bloc_tutorial/model/movie_detail_response.dart';
import 'package:bloc_tutorial/util/api_response.dart';
import 'package:equatable/equatable.dart';

class MovieDetailState extends Equatable {
  final ApiResponse<TVShowDetailResponse> tvShow;

  const MovieDetailState({required this.tvShow});

  MovieDetailState copyWith({ApiResponse<TVShowDetailResponse>? tvShow}) {
    return MovieDetailState(tvShow: tvShow ?? this.tvShow);
  }

  @override
  List<Object?> get props => [tvShow];
}
