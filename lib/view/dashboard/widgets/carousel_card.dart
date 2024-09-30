import 'package:bloc_tutorial/bloc/carousel_img_bloc/carousel_img_bloc.dart';
import 'package:bloc_tutorial/bloc/carousel_img_bloc/carousel_img_event.dart';
import 'package:bloc_tutorial/bloc/carousel_img_bloc/carousel_img_state.dart';
import 'package:bloc_tutorial/repository/movie_repository.dart';
import 'package:bloc_tutorial/util/common_widget.dart';
import 'package:bloc_tutorial/util/const_string.dart';
import 'package:bloc_tutorial/util/enums.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarouselCard extends StatefulWidget {
  const CarouselCard({super.key});

  @override
  State<CarouselCard> createState() => _CarouselCardState();
}

class _CarouselCardState extends State<CarouselCard> {
  late CarouselBloc _carouselBloc;
  MovieRepository repository = MovieRepository();

  @override
  void initState() {
    _carouselBloc = CarouselBloc(repository: repository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _carouselBloc..add(CarouselFetchEvent()),
        child: BlocBuilder<CarouselBloc, CarouselState>(
            buildWhen: (previous, current) =>
                current.carouselList.data != previous.carouselList.data,
            builder: ((context, state) {
              return Container(
                  child: state.carouselList.status == Status.loading
                      ? CarouselSlider.builder(
                          itemCount: 5,
                          itemBuilder: (context, index, realIndex) {
                            return CommonWidget.commonShimmer(
                                width: MediaQuery.of(context).size.width - 30,
                                height: MediaQuery.of(context).size.height / 3,
                                radius: 20);
                          },
                          options: CarouselOptions(
                              height: MediaQuery.of(context).size.height / 3,
                              enlargeCenterPage: true,
                              reverse: false))
                      : state.carouselList.status == Status.error
                          ? Center(
                              child:
                                  Text(state.carouselList.message.toString()),
                            )
                          : state.carouselList.data?.tvShows?.isEmpty == true
                              ? const Center(
                                  child: Text('No Information Found'),
                                )
                              : CarouselSlider.builder(
                                  itemCount:
                                      state.carouselList.data?.tvShows?.length,
                                  itemBuilder: ((context, index, realIndex) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                30,
                                        fit: BoxFit.cover,
                                        state.carouselList.data?.tvShows?[index]
                                                .imageThumbnailPath ??
                                            "",
                                        // loadingBuilder: (context, child,
                                        //         loadingProgress) =>
                                        //     SvgPicture.asset(
                                        //         ImageConstString.image_require),
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return SvgPicture.asset(imageRequire);
                                        },
                                      ),
                                    );
                                  }),
                                  options: CarouselOptions(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      // aspectRatio: 0.5,
                                      enlargeCenterPage: true,
                                      reverse: false)));
            })));
  }
}
