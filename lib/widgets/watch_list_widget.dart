import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_movies/firebase/firebase.dart';
import 'package:test_movies/models/film.dart';
import 'package:test_movies/utils/colors_app.dart';
import 'package:test_movies/utils/theme_app.dart';
import 'package:test_movies/widgets/movie_details_widget/movie_view_widget.dart';

class WatchListWidget extends StatefulWidget {
  final Film result;

  const WatchListWidget({Key? key, required this.result});

  @override
  State<WatchListWidget> createState() => _WatchListWidgetState();
}

class _WatchListWidgetState extends State<WatchListWidget> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MovieView.routeName, arguments: widget.result);
      },
      child: Row(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl:
                'https://image.tmdb.org/t/p/w500${widget.result.backdropPath ?? ''}',
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.1,
                alignment: Alignment.center,
                placeholder: (_, __) => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
                errorWidget: (_, __, ___) => const Icon(
                  Icons.image_not_supported_outlined,
                  color: Colors.red,
                ),
              ),
              buildIcon(widget.result) // Pass widget.result to buildIcon function
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.result.title ?? '',
                  style: AppTheme.movieTitle,
                ),
                Text(
                  widget.result.releaseDate ?? '',
                  style: AppTheme.time,
                ),
                Text(
                  widget.result.originalTitle ?? '',
                  style: AppTheme.time,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Positioned buildIcon(Film film) { // Change the argument type to Film
    return Positioned(
        left: 10,
        bottom: 53,
        child: IconButton(
          onPressed: () {
            toggleBookmark(film);
          },
          icon: const Icon(Icons.bookmark_add, size: 25),
          color: AppColors.selectIcon,
        ));
  }

  void toggleBookmark(Film film) {
    setState(() {
      isBookmarked = !isBookmarked;
      if (isBookmarked) {
        String filmTitle = film.title ?? "";
        FirebaseUtils.getFilmId(filmTitle).then((filmId) {
          if (filmId != null) {
            FirebaseUtils.deleteFilm(filmId).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Film Removed Successfully.'),
                ),
              );
            }).catchError((error) {
              print('Error deleting film: $error');
            });
          } else {
            print('Film not found in database.');
          }
        });
      }
    });
  }
}
