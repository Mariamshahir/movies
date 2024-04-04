import 'dart:convert';
import 'package:http/http.dart';
import 'package:test_movies/models/Upcoming_response.dart';
import 'package:test_movies/models/popular__response.dart';
import 'package:test_movies/models/toprated_response.dart';

abstract class ApiManger {
  static const String defaultErrorMessage = "Something went please again later";
  static const String baseUrl = "https://api.themoviedb.org";
  static const Map<String, String> header = {
    "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNzc0ZDBiNDY2YjhjOTM1MjE1NGM3ZmI4NDM0Y2ZiYyIsInN1YiI6IjY2MGE4Y2I3ZDZkYmJhMDE3ZDZmOWQ0OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ULzKdEgHt1iA5RGl3XhYMa1jy72LOvaiu3-bViJJDmk",
    "accept": "application/json"
  };

  static Future<PopularResponse> loadpopularlist() async {
    try {
      Uri url = Uri.parse("$baseUrl/3/movie/popular");
      Response response = await get(url, headers: header);
      Map myBody = jsonDecode(response.body);
      PopularResponse popularResponse = PopularResponse.fromJson(myBody);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return popularResponse;
      } else {
        throw popularResponse.statusMessage ?? defaultErrorMessage;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<UpcomingResponse> loadupcominglist() async {
    try {
      Uri url = Uri.parse("$baseUrl/3/movie/upcoming");
      Response response = await get(url, headers: header);
      Map myBody = jsonDecode(response.body);
//      print(myBody["results"]);
      UpcomingResponse upcomingResponse = UpcomingResponse.fromJson(myBody);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return upcomingResponse;
      } else {
        throw upcomingResponse.statusMessage ?? defaultErrorMessage;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<TopratedResponse> loadtopratedlist() async {
    try {
      Uri url = Uri.parse("$baseUrl/3/movie/top_rated");
      Response response = await get(url, headers: header);
      Map myBody = jsonDecode(response.body);
      TopratedResponse topratedResponse = TopratedResponse.fromJson(myBody);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return topratedResponse;
      } else {
        throw topratedResponse.statusMessage ?? defaultErrorMessage;
      }
    } catch (e) {
      rethrow;
    }
  }
}
