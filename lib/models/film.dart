class Film {
  static const String collectionName = "film";
  late String title;
  late String originalTitle;
  late String backdropPath;
  late String releaseDate;
  late bool video;

  Film({
    required this.backdropPath,
    required this.originalTitle,
    required this.releaseDate,
    required this.title,
    this.video = false,
  });

  Film.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    originalTitle = json['original_title'];
    releaseDate = json['release_date'];
    title = json['title'];
    video = json['is_bookmarked'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['backdrop_path'] = backdropPath;
    data['original_title'] = originalTitle;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['is_bookmarked'] = video;
    return data;
  }

  // static Future<List<Film>> getFilmsFromFirestore() async {
  //   try {
  //     QuerySnapshot querySnapshot =
  //     await FirebaseFirestore.instance.collection(collectionName).get();
  //
  //     List<Film> films = querySnapshot.docs.map((doc) {
  //       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  //       return Film.fromJson(data);
  //     }).toList();
  //
  //     return films;
  //   } catch (e) {
  //     print('Error fetching films from Firestore: $e');
  //     throw Exception('Failed to fetch films from Firestore');
  //   }
  // }
}
