import 'package:flutter/material.dart';
import 'package:test_movies/models/one_movie_dm.dart';
import 'package:test_movies/utils/colors_app.dart';
import 'package:test_movies/utils/theme_app.dart';

class ShowOneMovie extends StatelessWidget {
  final OneMovieDM movie;

  const ShowOneMovie({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Image.network(
                  movie.backdropPath,
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.5,
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: AppTheme.movieTitle.copyWith(fontSize: 20),
                    ),
                    Text(
                      movie.releaseDate,
                      style: AppTheme.time.copyWith(fontSize: 15),
                    ),
                    Text(
                      movie.author,
                      style: AppTheme.time.copyWith(fontSize: 15),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        const Divider(color: AppColors.divider),
      ],
    );
  }
}
