import 'package:flutter/material.dart';
import 'package:test_movies/models/movie_dm.dart';
import 'package:test_movies/tabs/show_movies/show_one_movie.dart';

class SearchListView extends StatefulWidget {
  List<MovieDM> movie = [];

  SearchListView({Key? key, required this.movie}) : super(key: key);

  @override
  State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.movie.length,
            itemBuilder: (context, index) {
              return ShowOneMovie(movie: widget.movie[index]);
            },
          ),
        ),
      ],
    );
  }
}
