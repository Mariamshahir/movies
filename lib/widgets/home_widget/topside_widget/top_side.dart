import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test_movies/data/api_manger.dart';
import 'package:test_movies/models/movie_dm.dart';
import 'package:test_movies/widgets/app_error.dart';
import 'package:test_movies/widgets/home_widget/topside_widget/items_top.dart';
import 'package:test_movies/widgets/lodding_app.dart';

class TopSide extends StatefulWidget {
  const TopSide({super.key});

  @override
  State<TopSide> createState() => _TopSideState();
}

class _TopSideState extends State<TopSide> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManger.loadPopularList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const AppError(
            error: "Something wrong please again later",
          );
        } else if (snapshot.hasData) {
          return topSide(context, snapshot.data!.results!);
        } else {
          return const LoaddingApp();
        }
      },
    );
  }

  Widget topSide(BuildContext context, List<MovieDM> result) {
    List<MovieDM> populerList = [];
    if (result.length > 10) {
      for (int i = 0; i < 10; i++) {
        populerList.add(result[i]);
      }
    } else {
      populerList = result;
    }

    return CarouselSlider(
      items: populerList.map((result) => PoplerItems(result: result)).toList(),
      options: CarouselOptions(
        enlargeCenterPage: true,
        autoPlay: false,
        height: double.infinity,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 500),
        viewportFraction: 0.98,
      ),
    );
  }
}
