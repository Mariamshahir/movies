class Film {
  static const String collectionName = "film";
  late String title;
  late int id;
  late String originalTitle;
  late String backdropPath;
  late String releaseDate;
  late bool video;

  Film({
    required this.backdropPath,
    required this.originalTitle,
    required this.releaseDate,
    required this.title,
    required this.id,
    this.video = false,
  });

  Film.fromJson(Map<String, dynamic> json) {
    backdropPath = json['backdrop_path'];
    originalTitle = json['original_title'];
    releaseDate = json['release_date'];
    title = json['title'];
    id = json['id'];
    video = json['is_bookmarked'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['backdrop_path'] = backdropPath;
    data['original_title'] = originalTitle;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['is_bookmarked'] = video;
    data['id'] = id;
    return data;
  }

}
