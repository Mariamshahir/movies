import 'package:flutter/material.dart';
import 'package:test_movies/models/movie_dm.dart';
import 'package:test_movies/utils/colors_app.dart';
import 'package:test_movies/utils/theme_app.dart';
import 'package:test_movies/widgets/movie_details_widget/movie_view_widget.dart';

class ShowOneMovie extends StatefulWidget {
  final MovieDM movie;

  const ShowOneMovie({Key? key, required this.movie}) : super(key: key);

  @override
  State<ShowOneMovie> createState() => _ShowOneMovieState();
}

class _ShowOneMovieState extends State<ShowOneMovie> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed (
          context,
          MovieView.routeName,
          arguments: widget.movie,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Image.network(
                    widget.movie.backdropPath ?? '',
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.5,
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.movie.title ?? '',
                        style: AppTheme.movieTitle.copyWith(fontSize: 20),
                      ),
                      Text(
                        widget.movie.releaseDate ?? '',
                        style: AppTheme.time.copyWith(fontSize: 15),
                      ),
                      Text(
                        widget.movie.originalTitle ?? '',
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
      ),
    );
  }
}
