import 'package:bloc_tutorial/bloc/movie_bloc/movie_bloc.dart';
import 'package:bloc_tutorial/bloc/movie_bloc/movie_event.dart';
import 'package:bloc_tutorial/bloc/movie_bloc/movie_state.dart';
import 'package:bloc_tutorial/repository/movie_repository.dart';
import 'package:bloc_tutorial/util/common_widget.dart';
import 'package:bloc_tutorial/util/enums.dart';
import 'package:bloc_tutorial/view/dashboard/widgets/movie_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllMovie extends StatefulWidget {
  const AllMovie({super.key});

  @override
  State<AllMovie> createState() => _AllMovieState();
}

class _AllMovieState extends State<AllMovie> {
  late MovieBloc movieBloc;
  MovieRepository repository = MovieRepository();

  @override
  void initState() {
    movieBloc = MovieBloc(repository: repository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => movieBloc..add(MovieFetchEvent())),
      child: BlocBuilder<MovieBloc, MovieState>(
          buildWhen: (previous, current) =>
              current.movieList.data?.tvShows !=
              previous.movieList.data?.tvShows,
          builder: (context, state) {
            switch (state.movieList.status) {
              case Status.loading:
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              childAspectRatio: 0.65),
                      itemCount: 10,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: CommonWidget.commonShimmer(
                              width: MediaQuery.of(context).size.width / 2,
                              height: 200,
                              radius: 10),
                        );
                      })),
                );
              case Status.error:
                return Center(
                  child: Text(state.movieList.message.toString()),
                );
              case Status.complete:
                final movieList = state.movieList.data?.tvShows ?? [];
                final loadMore = !((state.movieList.data?.page ?? 1) >
                    (state.movieList.data?.pages ?? 1));
                return NotificationListener<ScrollEndNotification>(
                    onNotification: (scrollInfo) {
                      scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent &&
                              loadMore
                          ? SchedulerBinding.instance
                              .addPostFrameCallback((timeStamp) {
                              movieBloc.add(MovieFetchEvent());
                            })
                          : null;
                      return true;
                    },
                    child: movieList.isEmpty == true
                        ? const Center(
                            child: Text('No Data Found'),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 0.65),
                                itemCount: loadMore
                                    ? movieList.length + 1
                                    : movieList.length,
                                itemBuilder: ((context, index) {
                                  return loadMore && index == movieList.length
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                                Colors.orange),
                                          ),
                                        )
                                      : MovieCard(movie: movieList[index]);
                                })),
                          ));
              case null:
                return const Center(
                  child: Text('null'),
                );
            }
          }),
    );
  }
}
