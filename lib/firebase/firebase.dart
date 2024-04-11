import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:test_movies/models/film.dart';

class FirebaseUtils {
  static CollectionReference getFilmCollection() {
    return FirebaseFirestore.instance.collection('films');
  }

  static Future<void> deleteFilm(String filmId) async {
    try {
      await getFilmCollection().doc(filmId).delete();
      print('Film deleted successfully');
    } catch (e) {
      print('Error deleting film: $e');
      throw e;
    }
  }

  static Future<void> storeDataInFirestore(
      Map<String, dynamic> filmsData) async {
    try {
      await getFilmCollection().doc('movies').set(filmsData);
      print('Data stored successfully in Firestore');
    } catch (e) {
      print('Error storing data in Firestore: $e');
      throw e;
    }
  }

  static Future<void> fetchAndStoreDataFromAPIs() async {
    try {
      var popularData =
          await fetchDataFromAPI('https://api.themoviedb.org/3/movie/popular');
      var upcomingData =
          await fetchDataFromAPI('https://api.themoviedb.org/3/movie/upcoming');
      var topRatedData = await fetchDataFromAPI(
          'https://api.themoviedb.org/3/movie/top_rated');
      var similarData = await fetchDataFromAPI(
          'https://api.themoviedb.org/3/movie/{movie_id}/similar');
      var processedData =
          processData(popularData, upcomingData, topRatedData, similarData);
      await Future.forEach(processedData.entries, (entry) async {
        await addFilmToFirestore(entry.value);
      });
    } catch (e) {
      print('Error fetching and storing data: $e');
      throw e;
    }
  }

  static Future<Map<String, dynamic>> fetchDataFromAPI(String apiUrl) async {
    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (e) {
      print('Error fetching data from API: $e');
      throw Exception('Failed to load data from API');
    }
  }

  static Map<String, dynamic> processData(
      Map<String, dynamic> popularData,
      Map<String, dynamic> upcomingData,
      Map<String, dynamic> topRatedData,
      Map<String, dynamic> similarData) {
    Map<String, dynamic> combinedData = {
      'popular': popularData,
      'upcoming': upcomingData,
      'topRated': topRatedData,
      'similar': similarData
    };

    return combinedData;
  }

  static Future<String?> getFilmId(String filmTitle) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('films')
          .where('title', isEqualTo: filmTitle)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching film ID: $e');
      return null;
    }
  }

  static Future<List<Film>> getAllMoviesFromFirestore() async {
    try {
      QuerySnapshot querySnapshot = await getFilmCollection().get();

      List<Film> movies = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return Film.fromJson(data);
      }).toList();

      return movies;
    } catch (e) {
      print('Error fetching movies from Firestore: $e');
      throw Exception('Failed to fetch movies from Firestore');
    }
  }

  static Future<DocumentReference> addFilmToFirestore(
      Map<String, dynamic> filmData) async {
    CollectionReference filmsCollection = getFilmCollection();

    // Add the film data to Firestore and get the reference
    DocumentReference newDocRef = await filmsCollection.add(filmData);

    // Update the document with its ID
    await newDocRef.update({
      'id': newDocRef.id,
    });

    return newDocRef;
  }
}
