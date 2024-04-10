import 'package:flutter/material.dart';
import 'package:test_movies/data/api_manger.dart';
import 'package:test_movies/models/categories_response.dart';
import 'package:test_movies/utils/assets_app.dart';
import 'package:test_movies/utils/theme_app.dart';
import 'package:test_movies/widgets/app_error.dart';
import 'package:test_movies/widgets/browse_widget/browse_widget.dart';
import 'package:test_movies/widgets/lodding_app.dart';

class BrowseTab extends StatelessWidget {
  const BrowseTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiManger.loadCategoriesList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const AppError(error: "Something wrong please again later");
          } else if (snapshot.hasData) {
            return listBrowseTabList(snapshot.data!.genres!);
          } else {
            return const LoaddingApp();
          }
        });
  }

  Widget listBrowseTabList(List<Genres> genres) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Browse Category ",
            style: AppTheme.watchList,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                  itemCount: genres.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 38),
                  itemBuilder: (context, index) {
                    return listBrowseTab(context, genres[index]);
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget listBrowseTab(BuildContext context, Genres genre) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BrowseWidget(
              categoryId: genre.id!.toInt(),
              categoryName: genre.name!,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Image(
            image: const AssetImage(AppAssets.background),
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.black26,
            ),
          ),
          Center(
              child: Text(
            genre.name ?? '',
            style: AppTheme.titleCategory,
          ))
        ],
      ),
    );
  }
}
