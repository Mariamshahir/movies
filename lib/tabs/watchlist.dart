import 'package:flutter/material.dart';
import 'package:test_movies/firebase/firebase.dart';
import 'package:test_movies/models/film.dart';
import 'package:test_movies/utils/colors_app.dart';
import 'package:test_movies/utils/theme_app.dart';
import 'package:test_movies/widgets/app_error.dart';
import 'package:test_movies/widgets/lodding_app.dart';
import 'package:test_movies/widgets/watch_list_widget.dart';

class WatchListTab extends StatelessWidget {
  const WatchListTab({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Film>>(
      future: FirebaseUtils.getAllMoviesFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoaddingApp();
        } else if (snapshot.hasError) {
          return const AppError(error: "Something went wrong. Please try again later.");
        } else if (snapshot.hasData) {
          final movies = snapshot.data!;
          return listWatchList(movies);
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget listWatchList(List<Film> movies) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Watchlist",
            style: AppTheme.watchList,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: movies.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: AppColors.divider,
                  thickness: 2,
                  indent: 5,
                );
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: WatchListWidget(result: movies[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}