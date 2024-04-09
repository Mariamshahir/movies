import 'package:flutter/material.dart';
import 'package:test_movies/data/api_manger.dart';
import 'package:test_movies/models/movie_response.dart';
import 'package:test_movies/utils/colors_app.dart';
import 'package:test_movies/utils/theme_app.dart';
import 'package:test_movies/widgets/app_error.dart';
import 'package:test_movies/widgets/lodding_app.dart';

class ItemGenres extends StatelessWidget {
  final int movieId;

  const ItemGenres({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManger.loadDetailsList(movieId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const AppError(
            error: "Something wrong please again later",
          );
        } else if (snapshot.hasData) {
          return itemGenresList(context, snapshot.data!.genres!);
        } else {
          return const LoaddingApp();
        }
      },
    );
  }

  Widget itemGenresList(BuildContext context, List<Genres> genres) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: GridView.builder(
          itemCount: genres.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 9,
          ),
          itemBuilder: (context, index) {
            return genre(context, genres[index]);
          }),
    );
  }

  Widget genre(BuildContext context, Genres genre) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: AppColors.gray),
            borderRadius: BorderRadius.circular(4)),
        child: Text(
          genre.name ?? '',
          style: AppTheme.time,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
