import 'package:bloc_tutorial/bloc/carousel_img_bloc/carousel_img_event.dart';
import 'package:bloc_tutorial/bloc/carousel_img_bloc/carousel_img_state.dart';
import 'package:bloc_tutorial/repository/movie_repository.dart';
import 'package:bloc_tutorial/util/api_response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselBloc extends Bloc<CarouselEvent, CarouselState> {
  MovieRepository repository = MovieRepository();

  CarouselBloc({required this.repository})
      : super(CarouselState(carouselList: ApiResponse.loading())) {
    on<CarouselFetchEvent>(_fetchCarousel);
  }

  void _fetchCarousel(
      CarouselFetchEvent event, Emitter<CarouselState> emit) async {
    await repository.fetchMovieList(10).then((value) {
      emit(state.copyWith(carouselList: ApiResponse.complete(value)));
    }).onError((error, stackTrace) {
      emit(state.copyWith(carouselList: ApiResponse.error(error.toString())));
    });
  }
}
