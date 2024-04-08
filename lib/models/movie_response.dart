/// adult : false
/// backdroppath : "/xJHokMbljvjADYdit5fK5VQsXEG.jpg"
/// belongsto_collection : null
/// budget : 165000000
/// genres : [{"id":12,"name":"Adventure"},{"id":18,"name":"Drama"},{"id":878,"name":"Science Fiction"}]
/// homepage : "http://www.interstellarmovie.net/"
/// id : 157336
/// imdbid : "tt0816692"
/// original_language : "en"
/// originaltitle : "Interstellar"
/// overview : "The adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel and conquer the vast distances involved in an interstellar voyage."
/// popularity : 174.689
/// posterpath : "/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg"
/// production_companies : [{"id":923,"logopath":"/8M99Dkt23MjQMTTWukq4m5XsEuo.png","name":"Legendary Pictures","origin_country":"US"},{"id":9996,"logopath":"/3tvBqYsBhxWeHlu62SIJ1el93O7.png","name":"Syncopy","origin_country":"GB"},{"id":13769,"logopath":null,"name":"Lynda Obst Productions","origin_country":""}]
/// production_countries : [{"iso_3166_1":"GB","name":"United Kingdom"},{"iso_3166_1":"US","name":"United States of America"}]
/// release_date : "2014-11-05"
/// revenue : 701729206
/// runtime : 169
/// spoken_languages : [{"englishname":"English","iso_639_1":"en","name":"English"}]
/// status : "Released"
/// tagline : "Mankind was born on Earth. It was never meant to die here."
/// title : "Interstellar"
/// video : false
/// vote_average : 8.432
/// vote_count : 34011

class MovieResponse {
  bool? adult;
  String? backdropPath;
  dynamic belongsToCollection;
  num? budget;
  List<Genres>? genres;
  String? homepage;
  num? id;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  num? popularity;
  String? posterPath;
  List<ProductionCompanies>? productionCompanies;
  List<ProductionCountries>? productionCountries;
  String? releaseDate;
  num? revenue;
  num? runtime;
  List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  num? voteAverage;
  num? voteCount;
  String? statusCode;
  String? statusMessage;

  MovieResponse({this.title,
    this.statusMessage,
    this.statusCode,
    this.id,
    this.tagline,
    this.voteAverage,
    this.runtime,
    this.productionCompanies,
    this.adult,
    this.backdropPath,
    this.popularity,
    this.voteCount,
    this.originalTitle,
    this.releaseDate,
    this.posterPath,
    this.originalLanguage,
    this.overview,
    this.video,
    this.spokenLanguages,
    this.revenue,
    this.productionCountries,
    this.imdbId,
    this.homepage,
    this.genres,
    this.budget,
    this.belongsToCollection,
    this.status});

  MovieResponse.fromJson(dynamic json) {
    adult = json['adult'];
    backdropPath = json['backdroppath'];
    belongsToCollection = json['belongsto_collection'];
    statusCode = json['status_code'];
    statusMessage = json['status_message'];
    budget = json['budget'];
    if (json['genres'] != null) {
      genres = [];
      json['genres'].forEach((v) {
        genres?.add(Genres.fromJson(v));
      });
    }
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdbid'];
    originalLanguage = json['original_language'];
    originalTitle = json['originaltitle'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['posterpath'];
    if (json['production_companies'] != null) {
      productionCompanies = [];
      json['production_companies'].forEach((v) {
        productionCompanies?.add(ProductionCompanies.fromJson(v));
      });
    }
    if (json['production_countries'] != null) {
      productionCountries = [];
      json['production_countries'].forEach((v) {
        productionCountries?.add(ProductionCountries.fromJson(v));
      });
    }
    releaseDate = json['release_date'];
    revenue = json['revenue'];
    runtime = json['runtime'];
    if (json['spoken_languages'] != null) {
      spokenLanguages = [];
      json['spoken_languages'].forEach((v) {
        spokenLanguages?.add(SpokenLanguages.fromJson(v));
      });
    }
    status = json['status'];
    tagline = json['tagline'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = adult;
    map['backdroppath'] = backdropPath;
    map['belongsto_collection'] = belongsToCollection;
    map['budget'] = budget;
    if (genres != null) {
      map['genres'] = genres?.map((v) => v.toJson()).toList();
    }
    map['homepage'] = homepage;
    map['id'] = id;
    map['imdbid'] = imdbId;
    map['original_language'] = originalLanguage;
    map['originaltitle'] = originalTitle;
    map['overview'] = overview;
    map['popularity'] = popularity;
    map['posterpath'] = posterPath;
    if (productionCompanies != null) {
      map['production_companies'] =
          productionCompanies?.map((v) => v.toJson()).toList();
    }
    if (productionCountries != null) {
      map['production_countries'] =
          productionCountries?.map((v) => v.toJson()).toList();
    }
    map['release_date'] = releaseDate;
    map['revenue'] = revenue;
    map['runtime'] = runtime;
    if (spokenLanguages != null) {
      map['spoken_languages'] =
          spokenLanguages?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    map['tagline'] = tagline;
    map['title'] = title;
    map['video'] = video;
    map['vote_average'] = voteAverage;
    map['vote_count'] = voteCount;
    return map;
  }
}

/// englishname : "English"
/// iso_639_1 : "en"
/// name : "English"

class SpokenLanguages {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguages({this.name, this.iso6391, this.englishName});

  SpokenLanguages.fromJson(dynamic json) {
    englishName = json['englishname'];
    iso6391 = json['iso_639_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['englishname'] = englishName;
    map['iso_639_1'] = iso6391;
    map['name'] = name;
    return map;
  }
}

/// iso_3166_1 : "GB"
/// name : "United Kingdom"

class ProductionCountries {
  String? iso31661;
  String? name;

  ProductionCountries({this.name, this.iso31661});

  ProductionCountries.fromJson(dynamic json) {
    iso31661 = json['iso_3166_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['iso_3166_1'] = iso31661;
    map['name'] = name;
    return map;
  }
}

/// id : 923
/// logopath : "/8M99Dkt23MjQMTTWukq4m5XsEuo.png"
/// name : "Legendary Pictures"
/// origin_country : "US"

class ProductionCompanies {
  num? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompanies({this.name, this.id, this.originCountry, this.logoPath});

  ProductionCompanies.fromJson(dynamic json) {
    id = json['id'];
    logoPath = json['logopath'];
    name = json['name'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['logopath'] = logoPath;
    map['name'] = name;
    map['origin_country'] = originCountry;
    return map;
  }
}

/// id : 12
/// name : "Adventure"

class Genres {
  num? id;
  String? name;

  Genres({this.id, this.name});

  Genres.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
