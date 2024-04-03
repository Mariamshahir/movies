import 'package:flutter/material.dart';
import 'package:test_movies/widgets/home_widget/new_realeases.dart';
import 'package:test_movies/widgets/home_widget/recommended.dart';
import 'package:test_movies/widgets/home_widget/top_side.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopSide(),
        SizedBox(height: 15,),
        NewRealeases(),
        SizedBox(height: 20,),
        Recommended()
      ],
    );
  }
}