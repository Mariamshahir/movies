import 'dart:convert';
import 'package:http/http.dart';
import 'package:test_movies/models/general_movie_response.dart';
import 'package:test_movies/models/movie_response.dart';

abstract class ApiManger {
  static const String defaultErrorMessage = "Something went please again later";
  static const String baseUrl = "https://api.themoviedb.org";
  static const String movieId = "157336";

  static const Map<String, String> header = {
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNzc0ZDBiNDY2YjhjOTM1MjE1NGM3ZmI4NDM0Y2ZiYyIsInN1YiI6IjY2MGE4Y2I3ZDZkYmJhMDE3ZDZmOWQ0OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ULzKdEgHt1iA5RGl3XhYMa1jy72LOvaiu3-bViJJDmk",
    "accept": "application/json"
  };
  static Future<GeneralResponse> loadPopularList() async {
    try {
      Uri url = Uri.parse("$baseUrl/3/movie/popular");
      Response response = await get(url, headers: header);
      Map myBody = jsonDecode(response.body);
      GeneralResponse popularResponse = GeneralResponse.fromJson(myBody);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return popularResponse;
      } else {
        throw popularResponse.statusMessage ?? defaultErrorMessage;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<GeneralResponse> loadUpcomingList() async {
    try {
      Uri url = Uri.parse("$baseUrl/3/movie/upcoming");
      Response response = await get(url, headers: header);
      Map myBody = jsonDecode(response.body);
      GeneralResponse upcomingResponse = GeneralResponse.fromJson(myBody);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return upcomingResponse;
      } else {
        throw upcomingResponse.statusMessage ?? defaultErrorMessage;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<GeneralResponse> loadTopRatedList() async {
    try {
      Uri url = Uri.parse("$baseUrl/3/movie/top_rated");
      Response response = await get(url, headers: header);
      Map myBody = jsonDecode(response.body);
      GeneralResponse topratedResponse = GeneralResponse.fromJson(myBody);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return topratedResponse;
      } else {
        throw topratedResponse.statusMessage ?? defaultErrorMessage;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<MovieResponse> loadDetailsList(int movieId) async {
    try {
      Uri url = Uri.parse("$baseUrl/3/movie/157336?id=$movieId");
      Response response = await get(url, headers: header);
      Map myBody = jsonDecode(response.body);
      MovieResponse movieResponse = MovieResponse.fromJson(myBody);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return movieResponse;
      } else {
        throw movieResponse.statusMessage ?? defaultErrorMessage;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<GeneralResponse> loadSimilarList() async {
    try {
      Uri url = Uri.parse("$baseUrl/3/movie/$movieId/similar");
      Response response = await get(url, headers: header);
      Map myBody = jsonDecode(response.body);
      GeneralResponse similarResponse = GeneralResponse.fromJson(myBody);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return similarResponse;
      } else {
        throw similarResponse.statusMessage ?? defaultErrorMessage;
      }
    } catch (e) {
      rethrow;
    }
  }
}
