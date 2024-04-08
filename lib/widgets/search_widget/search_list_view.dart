import 'package:flutter/material.dart';
import 'package:test_movies/models/one_movie_dm.dart';
import 'package:test_movies/tabs/show_movies/show_one_movie.dart';

class SearchListView extends StatefulWidget {
  List<OneMovieDM> searchResults = [];


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
              return ShowOneMovie(movie: widget.searchResults[index]);
              //Text(widget.searchResults[index]);
            },
          ),
        ),
      ],
    );
  }

// static List<String> allTitles = [];
// void getTitlesList(){
//   for(Results result in widget.resultsList){
//     allTitles.add(result.originalTitle!.toLowerCase());
//   }
}
