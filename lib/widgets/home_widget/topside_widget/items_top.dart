import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_movies/firebase/firebase.dart';
import 'package:test_movies/models/movie_dm.dart';
import 'package:test_movies/utils/colors_app.dart';
import 'package:test_movies/utils/theme_app.dart';
import 'package:test_movies/widgets/movie_details_widget/movie_view_widget.dart';

class PoplerItems extends StatefulWidget {
  final MovieDM result;

  const PoplerItems({Key? key, required this.result}) : super(key: key);

  @override
  State<PoplerItems> createState() => _PoplerItemsState();
}

class _PoplerItemsState extends State<PoplerItems> {
  bool isBookmarked = false;
  Map<int, bool> bookmarkStatus = {};

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
                  const SizedBox(
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
      right: 90,
      bottom: 150,
      child: InkWell(
        onTap: () {
          toggleBookmark();
        },
        child: bookmarkStatus[widget.result.id] ?? false
            ? const Icon(Icons.bookmark_add,
                color: AppColors.selectIcon, size: 30)
            : const Icon(
                Icons.bookmark_add,
                color: AppColors.bookMark,
                size: 30,
              ),
      ),
    );
  }

  void toggleBookmark() {
    setState(() {
      bookmarkStatus.update(
        widget.result.id!,
        (value) => !(value ?? false),
        ifAbsent: () => true,
      ); // Toggle bookmark status for the specific index

      if (bookmarkStatus[widget.result.id] ?? false) {
        FirebaseUtils.addFilmToFirestore(widget.result.toJson()).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Film Added Successfully to Watchlist.'),
            ),
          );
        }).catchError((error) {
          print('Error adding film to Firestore: $error');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to add film.'),
            ),
          );
        });
      } else {
        String filmTitle = widget.result.title ?? "";
        FirebaseUtils.getFilmId(filmTitle).then((filmId) {
          if (filmId != null) {
            FirebaseUtils.deleteFilm(filmId).then((value) {
              print('Film Deleted Successfully');
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
