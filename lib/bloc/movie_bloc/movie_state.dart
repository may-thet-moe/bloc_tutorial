
import 'package:bloc_tutorial/model/movie_list_response.dart';
import 'package:bloc_tutorial/util/api_response.dart';
import 'package:equatable/equatable.dart';

class MovieState extends Equatable{

  final ApiResponse<MovieListResponse> movieList;

  const MovieState({
    required this.movieList
  });

  MovieState copyWith({ApiResponse<MovieListResponse>? movieList}){
    return MovieState(movieList: movieList ?? this.movieList);
  }

  @override
  List<Object?> get props => [movieList];

}