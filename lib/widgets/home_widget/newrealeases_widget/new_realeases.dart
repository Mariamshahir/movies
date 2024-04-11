import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_movies/data/api_manger.dart';
import 'package:test_movies/firebase/firebase.dart';
import 'package:test_movies/models/movie_dm.dart';
import 'package:test_movies/utils/colors_app.dart';
import 'package:test_movies/utils/theme_app.dart';
import 'package:test_movies/widgets/app_error.dart';
import 'package:test_movies/widgets/lodding_app.dart';
import 'package:test_movies/widgets/movie_details_widget/movie_view_widget.dart';

class NewRealeases extends StatefulWidget {
  final MovieDM? movieResponse;

  const NewRealeases({super.key, required this.movieResponse});

  @override
  State<NewRealeases> createState() => _NewRealeasesState();
}

class _NewRealeasesState extends State<NewRealeases> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManger.loadTopRatedList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const AppError(
              error: "Something wrong please try again later");
        } else if (snapshot.hasData) {
          return newRealeasesList(snapshot.data!.results!);
        } else {
          return const LoaddingApp();
        }
      },
    );
  }

  Widget newRealeasesList(List<MovieDM> results) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "New Releases",
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
                  child: newRealeases(context, results[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget newRealeases(BuildContext context, MovieDM result) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MovieView.routeName, arguments: result);
      },
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.23,
        child:
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Center(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: CachedNetworkImage(
                    imageUrl:
                    'https://image.tmdb.org/t/p/w500${result.posterPath ?? ''}',
                    height: MediaQuery.of(context).size.height * 0.15,
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
                buildIcon(result), // Pass the movie to buildIcon()
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Positioned buildIcon(MovieDM movie) { // Accept MovieDM as an argument
    return Positioned(
      right: 65,
      bottom: 110,
      child: InkWell(
        onTap: () {
          _toggleBookmark(movie); // Pass the movie when tapped
        },
        child: isBookmarked
            ? Icon(Icons.bookmark_add, color: AppColors.selectIcon,)
            : Icon(Icons.bookmark_add, color: AppColors.bookMark,),
      ),
    );
  }

  void _toggleBookmark(MovieDM movie) {
    setState(() {
      isBookmarked = !isBookmarked;

      if (isBookmarked) {
        FirebaseUtils.addFilmToFirestore(movie.toJson()).then((value) {
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
        String filmTitle = movie.title ?? "";
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