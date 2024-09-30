import 'package:bloc_tutorial/bloc/favourite/favourite_bloc.dart';
import 'package:bloc_tutorial/bloc/favourite/favourite_event.dart';
import 'package:bloc_tutorial/bloc/favourite/favourite_state.dart';
import 'package:bloc_tutorial/util/common_widget.dart';
import 'package:bloc_tutorial/util/const_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouriteBloc, FavouriteState>(
        buildWhen: (previous, current) =>
            previous.favouriteList != current.favouriteList,
        builder: ((context, state) {
          return state.favouriteList.isEmpty == true
              ? const Center(
                  child: Text('Favourite List is Empty'),
                )
              : ListView.builder(
                  itemCount: state.favouriteList.length,
                  itemBuilder: ((context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: ListTile(
                        title: Text(state.favouriteList[index].name ?? ""),
                        subtitle:
                            Text(state.favouriteList[index].startDate ?? ""),
                        leading: Image.network(
                          width: 50,
                          height: 50,
                          fit: BoxFit.fill,
                          state.favouriteList[index].imageThumbnailPath ?? "",
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(imageRequire);
                          },
                        ),
                        trailing: InkWell(
                          onTap: () {
                            context.read<FavouriteBloc>().add(AddFavouriteEvent(
                                movie: state.favouriteList[index]));
                          },
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  }));
        }));
  }
}
