import 'package:bloc_tutorial/config/route/route_name.dart';
import 'package:bloc_tutorial/model/movie_list_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MovieCard extends StatefulWidget {
  const MovieCard({super.key, required this.movie});

  final TvShows movie;

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, RouteName.detailScreen,
          arguments: widget.movie.id.toString()),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 3,
              widget.movie.imageThumbnailPath.toString(),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
              top: 0,
              right: 10,
              child: Text(
                widget.movie.startDate.toString(),
                style: const TextStyle(color: Colors.orange, fontSize: 14),
              )),
        ],
      ),
    );
  }
}
