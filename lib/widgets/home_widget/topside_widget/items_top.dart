import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_movies/models/movie_dm.dart';
import 'package:test_movies/utils/colors_app.dart';
import 'package:test_movies/utils/theme_app.dart';
import 'package:test_movies/widgets/movie_details_widget/movie_view_widget.dart';

class PoplerItems extends StatefulWidget {
  final MovieDM result;

  const PoplerItems({super.key, required this.result});

  @override
  State<PoplerItems> createState() => _PoplerItemsState();
}

class _PoplerItemsState extends State<PoplerItems> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MovieView.routeName,
            arguments: widget.result);
      },
      child: Container(
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl:
                  'https://image.tmdb.org/t/p/w500${widget.result.backdropPath ?? ''}',
              fit: BoxFit.cover,
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
            Positioned(
              left: 10,
              top: 110,
              child: Row(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500${widget.result.posterPath ?? ''}',
                          height: MediaQuery.of(context).size.height * 0.2,
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
                      ),
                      buildIcon(),
                    ],
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 108),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.result.title ?? "",
                          style: AppTheme.title,
                        ),
                        Text(
                          widget.result.releaseDate ?? "",
                          style: AppTheme.time.copyWith(fontSize: 12),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned buildIcon() {
    return Positioned(
      right: 85,
      bottom: 140,
      child: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.bookmark_add,
            color: AppColors.bookMark,
            size: 30,
          )),
    );
  }
}
