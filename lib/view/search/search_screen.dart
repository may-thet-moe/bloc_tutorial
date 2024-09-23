import 'package:bloc_tutorial/bloc/search_bloc/search_bloc.dart';
import 'package:bloc_tutorial/bloc/search_bloc/search_event.dart';
import 'package:bloc_tutorial/bloc/search_bloc/search_state.dart';
import 'package:bloc_tutorial/repository/movie_repository.dart';
import 'package:bloc_tutorial/util/enums.dart';
import 'package:bloc_tutorial/view/dashboard/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  MovieRepository repository = MovieRepository();
  late SearchBloc _searchBloc;

  @override
  void initState() {
    _searchBloc = SearchBloc(repository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchBloc..add(SearchResultEvent(searchKey: '')),
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Search by Movie Name',
                  border: OutlineInputBorder()),
              onChanged: (value) {
                _searchBloc.add(SearchResultEvent(searchKey: value));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                  buildWhen: (previous, current) =>
                      previous.movieList != current.movieList,
                  builder: ((context, state) {
                    switch (state.status) {
                      case Status.loading:
                        return const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.blue),
                          ),
                        );
                      case Status.error:
                        return Center(
                          child: Text(state.successOrFailure),
                        );
                      case Status.complete:
                        return state.movieList.isEmpty
                            ? const Center(
                                child: Text('No data found'),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 0.65),
                                itemCount: state.movieList.length,
                                itemBuilder: ((context, index) {
                                  return MovieCard(
                                      movie: state.movieList[index]);
                                }));
                      default:
                        return const Center(
                          child: Text('Something Went Wrong'),
                        );
                    }
                  })),
            )
          ],
        ),
      )),
    );
  }
}
