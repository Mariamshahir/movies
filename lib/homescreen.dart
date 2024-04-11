import 'package:flutter/material.dart';
import 'package:test_movies/tabs/browse.dart';
import 'package:test_movies/tabs/home.dart';
import 'package:test_movies/tabs/watchlist.dart';
import 'package:test_movies/utils/colors_app.dart';

import 'tabs/show_movies/show_movies.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "homescreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndexTab = 0;
  List<Widget> bodyContent = [
    const HomeTab(),
    ShowMovies(),
    const BrowseTab(),
    const WatchListTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: buildBottomNavigationBar(),
      body: bodyContent[currentIndexTab],
    );
  }

  Widget buildBottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: AppColors.navigaterBar),
      child: BottomNavigationBar(
        showUnselectedLabels: true,
        currentIndex: currentIndexTab,
        onTap: (newTabIndex) {
          setState(() {
            currentIndexTab = newTabIndex;
          });
        },
        selectedFontSize: 15,
        unselectedFontSize: 10,
        unselectedItemColor: AppColors.unSelectIcon,
        selectedItemColor: AppColors.selectIcon,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "SEARCH"),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "BROWSE"),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt), label: "WATCHLIST")
        ],
      ),
    );
  }
}
