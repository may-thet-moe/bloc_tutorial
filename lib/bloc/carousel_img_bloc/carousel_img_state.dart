import 'package:bloc_tutorial/model/movie_list_response.dart';
import 'package:bloc_tutorial/util/api_response.dart';
import 'package:equatable/equatable.dart';

class CarouselState extends Equatable {
  final ApiResponse<MovieListResponse> carouselList;

  const CarouselState({required this.carouselList});

  CarouselState copyWith({ApiResponse<MovieListResponse>? carouselList}) {
    return CarouselState(carouselList: carouselList ?? this.carouselList);
  }

  @override
  List<Object?> get props => [carouselList];
}
