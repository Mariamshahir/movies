import 'package:flutter/material.dart';
import 'package:test_movies/models/movie_dm.dart';
import 'package:test_movies/widgets/movie_details_widget/more_like_widget/more_like_this_section.dart';
import 'package:test_movies/widgets/movie_details_widget/movie_details_widget/movie_details_widget.dart';

class MovieView extends StatefulWidget {
  static const String routeName = "movieview";

  const MovieView({
    Key? key,
  }) : super(key: key);

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  @override
  Widget build(BuildContext context) {
    MovieDM movie = ModalRoute.of(context)!.settings.arguments as MovieDM;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(flex: 8, child: MovieDetails(movieId: movie.id!.toInt())),
        const Expanded(
          flex: 4,
          child: MoreLikeThisSection(),
        ),
      ],
    );
  }
}
