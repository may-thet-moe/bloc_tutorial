import 'package:bloc_tutorial/model/movie_list_response.dart';
import 'package:bloc_tutorial/util/enums.dart';
import 'package:equatable/equatable.dart';

class SearchState extends Equatable {
  const SearchState({
    this.status = Status.loading,
    this.successOrFailure = '',
    this.movieList = const <TvShows>[],
  });

  final Status status;
  final String successOrFailure;
  final List<TvShows> movieList;

  SearchState copyWith({
    Status? status,
    String? searchKey,
    String? successOrFailure,
    List<TvShows>? movieList,
  }) {
    return SearchState(
      status: status ?? this.status,
      successOrFailure: successOrFailure ?? this.successOrFailure,
      movieList: movieList ?? this.movieList,
    );
  }

  @override
  List<Object?> get props => [status, movieList];
}
