import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_movies/homescreen.dart';
import 'package:test_movies/splash.dart';
import 'package:test_movies/utils/theme_app.dart';
import 'package:test_movies/widgets/movie_details_widget/movie_view_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCmT7-BnhZnI4vKZ-GOEJdHmrAGvckcx0A",
          appId: "movie-app-abbff",
          messagingSenderId: "movie-app-abbff",
          projectId: "movie-app-abbff"));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movies App",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routes: {
        Splash.routeName: (_) => const Splash(),
        HomeScreen.routeName: (_) => const HomeScreen(),
        MovieView.routeName: (_) => const MovieView(),
      },
      initialRoute: Splash.routeName,
    );
  }
}
