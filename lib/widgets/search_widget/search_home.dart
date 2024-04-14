import 'package:flutter/material.dart';
import 'package:test_movies/models/movie_dm.dart';
import 'package:test_movies/utils/colors_app.dart';
import 'package:test_movies/widgets/search_widget/search_list_view.dart';

class SearchHome extends StatefulWidget {
  static const routeName = "search_home";
  List<MovieDM> allMovies;

  SearchHome({super.key, required this.allMovies});

  bool selectedWidget = true;

  @override
  State<SearchHome> createState() => _SearchHomeState();
}

class _SearchHomeState extends State<SearchHome> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Container(
            //padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .2,
            ),
            height: MediaQuery.of(context).size.height * .06,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.search,
                border: Border.all(color: Colors.grey, width: 2),
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height * .2)),
            child: InkWell(
              onTap: () {
                widget.selectedWidget = false;
                setState(() {});
              },
              child: TextField(
                controller: controller,
                onChanged: onQueryChanged,
                decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: IconButton(
                        onPressed: () {
                          onQueryChanged;
                        },
                        icon: const Icon(
                          Icons.search,
                          color: AppColors.white,
                        )),
                    suffixIcon: IconButton(
                      onPressed: () {
                        widget.selectedWidget = true; //movie icon
                        controller = TextEditingController();
                        setState(() {});
                      },
                      icon: const Icon(Icons.close_outlined,
                          color: AppColors.white),
                    )),
              ),
            ),
          ),
        ),
        body: widget.selectedWidget == true
            ? localMoviesIcon()
            : SearchListView(movie: moviesSearchResults));
  }

  Widget localMoviesIcon() {
    return Center(
      child: Icon(
        Icons.local_movies,
        size: MediaQuery.of(context).size.height * .25,
        color: Colors.grey,
      ),
    );
  }

  List<String> searchResults = [];
  List<MovieDM> moviesSearchResults = [];

  void onQueryChanged(String searchWord) {
    widget.selectedWidget = false;
    for (MovieDM movieDM in widget.allMovies) {
      if (movieDM.title!.contains(searchWord.toLowerCase())) {
        moviesSearchResults.add(movieDM);
      }
    }

    SearchListView(movie: moviesSearchResults);
    setState(() {});
    print("==========================================");
    print(widget.allMovies);
  }
}
