import 'package:flutter/material.dart';
import 'package:test_movies/models/movie_dm.dart';
import 'package:test_movies/utils/colors_app.dart';
import 'package:test_movies/utils/theme_app.dart';

class ItemsRecommended extends StatefulWidget {
  final MovieDM result;

  const ItemsRecommended({super.key, required this.result});

  @override
  State<ItemsRecommended> createState() => _ItemsRecommendedState();
}

class _ItemsRecommendedState extends State<ItemsRecommended> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.star,
                color: AppColors.selectIcon,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.result.voteAverage?.toString() ?? "",
                style: AppTheme.time.copyWith(color: AppColors.white),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.result.title ?? "",
            style: AppTheme.time.copyWith(color: AppColors.white),
          ),
          Text(widget.result.releaseDate ?? "", style: AppTheme.time)
        ],
      ),
    );
  }
}
