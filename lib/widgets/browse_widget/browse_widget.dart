import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_movies/data/api_manger.dart';
import 'package:test_movies/models/movie_dm.dart';
import 'package:test_movies/utils/colors_app.dart';
import 'package:test_movies/utils/theme_app.dart';
import 'package:test_movies/widgets/app_error.dart';
import 'package:test_movies/widgets/lodding_app.dart';
import 'package:test_movies/widgets/movie_details_widget/movie_view_widget.dart';

class BrowseWidget extends StatelessWidget {
  final int categoryId;
  final String categoryName;

  const BrowseWidget({super.key, required this.categoryId, required this.categoryName,});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManger.loadMoviesForCategory(categoryId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const AppError(error: "Something wrong please try again later");
        } else if (snapshot.hasData) {
          return _buildList(snapshot.data!.results!);
        } else {
          return const LoaddingApp();
        }
      },
    );
  }

  Widget _buildList(List<MovieDM> results) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryName,
          style: AppTheme.titleName,
        ),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      backgroundColor: Colors.black,
      body: GridView.builder(
        itemCount: results.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          return _buildItem(context, results[index]);
        },
      ),
    );
  }

  Widget _buildItem(BuildContext context, MovieDM result) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MovieView.routeName, arguments: result);
      },
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${result.posterPath ?? ''}',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.5,
            placeholder: (_, __) => const Center(
              child: CircularProgressIndicator(color: Colors.blue),
            ),
            errorWidget: (_, __, ___) => const Icon(Icons.image_not_supported_outlined, color: Colors.red),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.black26,
            ),
          ),
          Center(
            child: Text(
              result.title ?? '',
              style: AppTheme.titleCategory,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
