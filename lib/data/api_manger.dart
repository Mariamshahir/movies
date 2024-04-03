import 'dart:convert';
import 'package:http/http.dart';
import 'package:test_movies/models/Upcoming_response.dart';
import 'package:test_movies/models/popular__response.dart';
import 'package:test_movies/models/toprated_response.dart';

abstract class ApiManger {
  static const String defaultErrorMessage = "Something went please again later";
  static const String baseUrl = "https://api.themoviedb.org";
  static const String apiKey = "1774d0b466b8c9352154c7fb8434cfbc";

  static Future<PopularResponse> loadpopularlist() async {
    try {
      Uri url = Uri.parse("$baseUrl/3/movie/popular?results&apiKey=$apiKey");
      Response response = await get(url);
      Map myBody = jsonDecode(response.body);
      print(myBody["results"]);
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
      Uri url = Uri.parse("$baseUrl/3/movie/upcoming?results&apiKey=$apiKey");
      Response response = await get(url);
      Map myBody = jsonDecode(response.body);
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
      Uri url = Uri.parse("$baseUrl/3/movie/top_rated?results&apiKey=$apiKey");
      Response response = await get(url);
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
