import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_movies/models/film.dart';
import 'package:test_movies/utils/colors_app.dart';
import 'package:test_movies/utils/theme_app.dart';
import 'package:test_movies/widgets/movie_details_widget/movie_view_widget.dart';

class WatchListWidget extends StatelessWidget {
  final Film result;

  const WatchListWidget({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MovieView.routeName, arguments: result);
      },
      child: Row(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl:
                    'https://image.tmdb.org/t/p/w500${result.backdropPath ?? ''}',
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
              buildIcon()
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result.title ?? '',
                  style: AppTheme.movieTitle,
                ),
                Text(
                  result.releaseDate ?? '',
                  style: AppTheme.time,
                ),
                Text(
                  result.originalTitle ?? '',
                  style: AppTheme.time,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Positioned buildIcon() {
    return Positioned(
        left: 10,
        bottom: 53,
        child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.bookmark_add, size: 25),
          color: AppColors.selectIcon,
        ));
  }
}
