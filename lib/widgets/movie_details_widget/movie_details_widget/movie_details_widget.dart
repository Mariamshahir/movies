import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_movies/data/api_manger.dart';
import 'package:test_movies/firebase/firebase.dart';
import 'package:test_movies/models/movie_dm.dart';
import 'package:test_movies/models/movie_response.dart';
import 'package:test_movies/utils/colors_app.dart';
import 'package:test_movies/utils/theme_app.dart';
import 'package:test_movies/widgets/app_error.dart';
import 'package:test_movies/widgets/lodding_app.dart';
import 'package:test_movies/widgets/movie_details_widget/movie_details_widget/itemgenres.dart';

class MovieDetails extends StatefulWidget {
  final int movieId;

  const MovieDetails({Key? key, required this.movieId});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManger.loadDetailsList(widget.movieId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const AppError(
            error: "Something wrong please again later",
          );
        } else if (snapshot.hasData) {
          return moviedetails(context, snapshot.data!);
        } else {
          return const LoaddingApp();
        }
      },
    );
  }

  Widget moviedetails(BuildContext context, MovieResponse movies) {
    MovieDM movie = ModalRoute.of(context)!.settings.arguments as MovieDM;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.title ?? '',
          style: AppTheme.titleName,
        ),
        backgroundColor: AppColors.part,
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w500${movie.backdropPath ?? ''}',
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
                const Center(child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 75),
                  child: Icon(Icons.play_circle,color: AppColors.white,size: 60,),
                ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title ?? '',
                    style: AppTheme.movieTitle,
                  ),
                  Text(movie.releaseDate ?? "", style: AppTheme.time),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Row(
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/w500${movie.posterPath ?? ''}',
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
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
                              buildIcon(movie),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 11,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      child:
                                          ItemGenres(movieId: widget.movieId)),
                                  Text(
                                    movie.overview ?? '',
                                    style: AppTheme.tagline,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star_outlined,
                                        size: 40,
                                        color: AppColors.selectIcon,
                                      ),
                                      const SizedBox(
                                        width: 6.5,
                                      ),
                                      Text(
                                        movie.voteAverage?.toString() ?? '',
                                        style: AppTheme.movieTitle,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
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

  Positioned buildIcon(MovieDM movie) {
    return Positioned(
      right: 90,
      bottom: 150,
      child: InkWell(
        onTap: () {
          toggleBookmark(movie);
        },
        child: isBookmarked
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

  void toggleBookmark(MovieDM movie) {
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
