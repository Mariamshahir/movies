import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test_movies/data/api_manger.dart';
import 'package:test_movies/models/popular__response.dart';
import 'package:test_movies/widgets/app_error.dart';
import 'package:test_movies/widgets/loddingapp.dart';

class TopSide extends StatelessWidget {
  const TopSide({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManger.loadpopularlist(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const AppError(
            error: "Something wrong please again later",
          );
        } else if (snapshot.hasData) {
          return topSideList(snapshot.data!.results!);
        } else {
          return const LoaddingApp();
        }
      },
    );
  }

  Widget topSideList(List<ResultPopular> results) {
    return Container(
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return topSide(context, results[index]);
        },
      ),
    );
  }

  Widget topSide(BuildContext context, ResultPopular result) {
    return CarouselSlider(
      items: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${result.posterPath ?? ''}',
          height: MediaQuery.of(context).size.height * 0.25,
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
      ],
      options: CarouselOptions(
        height: 200,
        enlargeCenterPage: true,
        autoPlay: true,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 500),
        viewportFraction: 0.9,
      ),
    );
  }
}
