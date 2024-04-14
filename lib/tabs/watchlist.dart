import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_movies/firebase/firebase.dart';
import 'package:test_movies/models/movie_dm.dart';
import 'package:test_movies/utils/colors_app.dart';
import 'package:test_movies/utils/theme_app.dart';
import 'package:test_movies/widgets/app_error.dart';
import 'package:test_movies/widgets/lodding_app.dart';
import 'package:test_movies/widgets/movie_details_widget/movie_view_widget.dart';


class WatchListTab extends StatefulWidget {

  const WatchListTab({Key? key}) : super(key: key);

  @override
  State<WatchListTab> createState() => _WatchListTabState();
}

class _WatchListTabState extends State<WatchListTab> {
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseUtils.getFilmCollection().snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoaddingApp();
        } else if (snapshot.hasError) {
          return const AppError(
              error: "Something went wrong. Please try again later.");
        } else {
          final movies = snapshot.data!.docs;
          return listWatchList(movies);
        }
      },
    );
  }

  Widget listWatchList(List<QueryDocumentSnapshot<Object?>> movies) {
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
                final movie = movies[index].data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: watchListWidget(movie, context),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget watchListWidget(Map<String, dynamic> movie, BuildContext context) {
    return InkWell(
      onTap: () {
        // print("")
        print("film: ${movie["id"]}");
        Navigator.pushNamed(context, MovieView.routeName,
            arguments: MovieDM.fromJson(movie));
      },

      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl:
                    "https://image.tmdb.org/t/p/w500${movie['backdrop_path']}",
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.12,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),
                    errorWidget: (_, __, ___) => const Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.red,
                    ),
                  ),
                  Positioned(
                    left: 5,
                    bottom: 82,
                    child: InkWell(
                      onTap: () {
                        FirebaseUtils.deleteFilm(movie['id'].toString());
                      },
                      child: const Icon(
                        Icons.bookmark_add,
                        color: AppColors.selectIcon,
                        size: 25,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 5,),
              Expanded(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie['title'] ?? '',
                      style: AppTheme.movieTitle,
                    ),
                    Text(movie['release_date'] ?? '', style: AppTheme.time),
                    Text(movie['original_title'] ?? '', style: AppTheme.time),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
