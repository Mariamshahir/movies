import 'package:flutter/material.dart';
import 'package:test_movies/utils/colors_app.dart';
import 'package:test_movies/widgets/home_widget/newrealeases_widget/new_realeases.dart';
import 'package:test_movies/widgets/home_widget/recommended_widget/recommended.dart';
import 'package:test_movies/widgets/home_widget/topside_widget/top_side.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(flex: 4, child: TopSide()),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 3,
            child: Container(
                decoration: const BoxDecoration(color: AppColors.part),
                height: MediaQuery.of(context).size.height * 0.25,
                child: const NewRealeases(
                  movieResponse: null,
                )),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
            flex: 4,
            child: Container(
                decoration: const BoxDecoration(color: AppColors.part),
                height: MediaQuery.of(context).size.height * 0.3,
                child: const Recommended()),
          )
        ],
      ),
    );
  }
}
