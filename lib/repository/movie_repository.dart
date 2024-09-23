import 'package:bloc_tutorial/model/movie_detail_response.dart';
import 'package:bloc_tutorial/model/movie_list_response.dart';
import 'package:bloc_tutorial/service/network_api_service.dart';
import 'package:bloc_tutorial/util/app_url.dart';

class MovieRepository {
  final _apiServices = NetworkApiServices();

  Future<MovieListResponse> fetchMovieList(int page) async {
    final response =
        await _apiServices.getAPi('${AppUrl.movieListEndPoint}$page');
    return MovieListResponse.fromJson(response);
  }

  Future<TVShowDetailResponse> movieDetail({required String movieName}) async {
    final response =
        await _apiServices.getAPi('${AppUrl.movieDetailEndPoint}$movieName');
    return TVShowDetailResponse.fromJson(response);
  }

  Future<List<TvShows>> getSearchResult(String searchKey) async {
    final response =
        await _apiServices.getAPi('${AppUrl.searchEndPoint}$searchKey');
    final resultList = MovieListResponse.fromJson(response).tvShows;
    return resultList ?? [];
  }
}
