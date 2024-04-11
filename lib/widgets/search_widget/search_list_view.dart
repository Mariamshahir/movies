import 'package:flutter/material.dart';
import 'package:test_movies/models/movie_dm.dart';
import 'package:test_movies/tabs/show_movies/show_one_movie.dart';
import 'package:test_movies/widgets/movie_details_widget/movie_view_widget.dart';

class SearchListView extends StatefulWidget {
  List<MovieDM> searchResults = [];


  SearchListView({super.key, required this.searchResults});

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
            itemCount: widget.searchResults.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, MovieView.routeName, arguments: widget.searchResults[index],);
                  },
                  child: ShowOneMovie(movie: widget.searchResults[index]));
            },
          ),
        ),
      ],
    );
  }

}
