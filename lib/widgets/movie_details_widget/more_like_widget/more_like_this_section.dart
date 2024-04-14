import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_movies/data/api_manger.dart';
import 'package:test_movies/firebase/firebase.dart';
import 'package:test_movies/models/movie_dm.dart';
import 'package:test_movies/utils/colors_app.dart';
import 'package:test_movies/utils/theme_app.dart';
import 'package:test_movies/widgets/app_error.dart';
import 'package:test_movies/widgets/home_widget/recommended_widget/item_recommended.dart';
import 'package:test_movies/widgets/lodding_app.dart';
import 'package:test_movies/widgets/movie_details_widget/movie_view_widget.dart';

class MoreLikeThisSection extends StatefulWidget {
  const MoreLikeThisSection({Key? key});

  @override
  State<MoreLikeThisSection> createState() => _MoreLikeThisSectionState();
}

class _MoreLikeThisSectionState extends State<MoreLikeThisSection> {
  bool isBookmarked = false;
  Map<int, bool> bookmarkStatus = {};
  List<MovieDM>? results;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManger.loadSimilarList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const AppError(
              error: "Something wrong please try again later");
        } else if (snapshot.hasData) {
          results = snapshot.data!.results;
          return moreLikeList(results!);
        } else {
          return const LoaddingApp();
        }
      },
    );
  }

  Widget moreLikeList(List<MovieDM> results) {
    return Scaffold(
      backgroundColor: AppColors.navigaterBar,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "More Like This",
              style: AppTheme.title,
            ),
            const SizedBox(
              height: 12.87,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: results.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: moreLike(context, results[index], index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget moreLike(BuildContext context, MovieDM result, int index) {
    String heroTag = 'more_like_${result.id}';

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MovieView.routeName, arguments: result);
      },
      child: Hero(
        tag: heroTag,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Color(0xff707070),
          ),
          width: MediaQuery.of(context).size.width * 0.22,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(6)),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w500${result.posterPath ?? ''}',
                        height: MediaQuery.of(context).size.height * 0.15,
                        alignment: Alignment.center,
                        placeholder: (_, __) => const Center(
                          child: CircularProgressIndicator(color: Colors.blue),
                        ),
                        errorWidget: (_, __, ___) => const Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    buildIcon(index),
                  ],
                ),
              ),
              ItemsRecommended(result: result),
            ],
          ),
        ),
      ),
    );
  }

  Positioned buildIcon(int index) {
    return Positioned(
      right: 60,
      bottom: 105,
      child: InkWell(
        onTap: () {
          toggleBookmark(index);
        },
        child: bookmarkStatus[index] ?? false
            ? const Icon(
                Icons.bookmark_add,
                color: AppColors.selectIcon,
                size: 30,
              )
            : const Icon(
                Icons.bookmark_add,
                color: AppColors.bookMark,
                size: 30,
              ),
      ),
    );
  }

  void toggleBookmark(int index) {
    setState(() {
      bookmarkStatus.update(
        index,
        (value) => !(value ?? false),
        ifAbsent: () => true,
      );
      final movie = results?[index];
      if (bookmarkStatus[index] ?? false) {
        FirebaseUtils.addFilmToFirestore(movie!.toJson()).then((value) {
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
        String filmTitle = movie?.title ?? "";
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
