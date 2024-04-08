import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_movies/data/api_manger.dart';
import 'package:test_movies/models/movie_dm.dart';
import 'package:test_movies/utils/colors_app.dart';
import 'package:test_movies/utils/theme_app.dart';
import 'package:test_movies/widgets/app_error.dart';
import 'package:test_movies/widgets/home_widget/recommended_widget/item_recommended.dart';
import 'package:test_movies/widgets/lodding_app.dart';
import 'package:test_movies/widgets/movie_details_widget/movie_view_widget.dart';

class MoreLikeThisSection extends StatefulWidget {
  const MoreLikeThisSection({super.key});

  @override
  State<MoreLikeThisSection> createState() => _MoreLikeThisSectionState();
}

class _MoreLikeThisSectionState extends State<MoreLikeThisSection> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManger.loadSimilarList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const AppError(
              error: "Something wrong please try again later");
        } else if (snapshot.hasData) {
          return moreLikeList(snapshot.data!.results!);
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
                    child: moreLike(context, results[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget moreLike(BuildContext context, MovieDM result) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MovieView.routeName, arguments: result);
      },
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
                  Positioned(
                    right: 55,
                    bottom: 95,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bookmark_add,
                        color: AppColors.bookMark,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ItemsRecommended(result: result)
          ],
        ),
      ),
    );
  }
}
