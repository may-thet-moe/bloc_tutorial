import 'package:bloc_tutorial/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:bloc_tutorial/bloc/movie_detail/movie_detail_event.dart';
import 'package:bloc_tutorial/bloc/movie_detail/movie_detail_state.dart';
import 'package:bloc_tutorial/repository/movie_repository.dart';
import 'package:bloc_tutorial/util/enums.dart';
import 'package:bloc_tutorial/view/detail/widgets/text_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.movieName});

  final String movieName;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late MovieDetailBloc _movieDetailBloc;
  final MovieRepository repository = MovieRepository();

  @override
  void initState() {
    _movieDetailBloc =
        MovieDetailBloc(repository: repository, movieName: widget.movieName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _movieDetailBloc..add(MovieDetailFetchEvent()),
      child: SafeArea(child: Scaffold(
        body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
            builder: ((context, state) {
          final data = state.tvShow.data?.tvShow;
          switch (state.tvShow.status) {
            case Status.loading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.error:
              return Center(
                child: Text(state.tvShow.message.toString()),
              );
            case Status.complete:
              return data == null
                  ? const Center(
                      child: Text("No Data Found"),
                    )
                  : ListView(
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              data.imageThumbnailPath.toString(),
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height / 2.3,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height / 2,
                              decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.center,
                                      stops: [
                                    0.23,
                                    1
                                  ],
                                      colors: [
                                    Color.fromARGB(255, 29, 28, 28),
                                    Colors.transparent
                                  ])),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, left: 15, right: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Offstage(
                                              offstage:
                                                  data.genres?.firstOrNull ==
                                                      null,
                                              child: TextCard(
                                                  message: (data.genres?.first)
                                                      .toString())),
                                          TextCard(
                                            message: data.rating.toString(),
                                            icon: Icons.star,
                                          )
                                        ],
                                      ),
                                      const Row(
                                        children: [
                                          Icon(
                                            Icons.favorite,
                                            size: 24,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Icon(
                                            Icons.share,
                                            size: 24,
                                            color: Colors.white,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 15, right: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.name.toString(),
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                data.description.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Poster Collection",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                height: 70,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.pictures?.length,
                                    itemBuilder: ((context, index) {
                                      return Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2, color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        width: 70,
                                        height: 70,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            (data.pictures?[index]).toString(),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    })),
                              )
                            ],
                          ),
                        )
                      ],
                    );
            default:
              return const Center(
                child: Text('Something Went Wrong'),
              );
          }
        })),
      )),
    );
  }
}
