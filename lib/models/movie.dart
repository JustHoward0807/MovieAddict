import 'dart:convert';

import 'package:hive/hive.dart';
part 'movie.g.dart';

List<Movie> movieFromJson(String str) => List<Movie>.from(json.decode(str).map((x) => Movie.fromJson(x)));

String movieToJson(List<Movie> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Movie {
    Movie({
        this.movieId,
        this.movieCnName,
        this.movieEnName,
        this.movieRating,
        this.movieImdbRating,
        this.movieDuration,
        this.movieCategory,
        this.releaseMovieTime,
        this.movieTrailer,
        this.moviePoster,
        this.moviePhotos,
        this.movieIntroduction,
        this.actors,
        
    });

    String movieId;
    String movieCnName;
    String movieEnName;
    String movieRating;
    String movieImdbRating;
    String movieDuration;
    List<String> movieCategory;
    String releaseMovieTime;
    String movieTrailer;
    String moviePoster;
    List<String> moviePhotos;
    String movieIntroduction;
    List<Actor> actors;
    

    factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        movieId: json["movie_id"],
        movieCnName: json["movie_cn_name"],
        movieEnName: json["movie_en_name"],
        movieRating: json["movie_rating"],
        movieImdbRating: json["movie_imdb_rating"],
        movieDuration: json["movie_duration"],
        movieCategory: List<String>.from(json["movie_category"].map((x) => x)),
        releaseMovieTime: json["release_movie_time"],
        movieTrailer: json["movie_trailer"],
        moviePoster: json["movie_poster"],
        moviePhotos: List<String>.from(json["movie_photos"].map((x) => x)),
        movieIntroduction: json["movie_introduction"],
        actors: List<Actor>.from(json["actors"].map((x) => Actor.fromJson(x))),
        
    );

    Map<String, dynamic> toJson() => {
        "movie_id": movieId,
        "movie_cn_name": movieCnName,
        "movie_en_name": movieEnName,
        "movie_rating": movieRating,
        "movie_imdb_rating": movieImdbRating,
        "movie_duration": movieDuration,
        "movie_category": List<dynamic>.from(movieCategory.map((x) => x)),
        "release_movie_time": releaseMovieTime,
        "movie_trailer": movieTrailer,
        "movie_poster": moviePoster,
        "movie_photos": List<dynamic>.from(moviePhotos.map((x) => x)),
        "movie_introduction": movieIntroduction,
        "actors": List<dynamic>.from(actors.map((x) => x.toJson())),
        
    };
}
@HiveType(typeId: 1)
class Actor extends HiveObject{
    Actor({
        this.actorCnName,
        this.actorEnName,
        this.actorPhotos,
    });
    @HiveField(0)
    String actorCnName;
    @HiveField(1)
    String actorEnName;
    @HiveField(2)
    String actorPhotos;

    factory Actor.fromJson(Map<String, dynamic> json) => Actor(
        // ignore: prefer_if_null_operators
        actorCnName: json["actor_cn_name"] == null ? null : json["actor_cn_name"],
        // ignore: prefer_if_null_operators
        actorEnName: json["actor_en_name"] == null ? null : json["actor_en_name"],
        // ignore: prefer_if_null_operators
        actorPhotos: json["actor_photos"] == null ? null : json["actor_photos"],
    );

    Map<String, dynamic> toJson() => {
        // ignore: prefer_if_null_operators
        "actor_cn_name": actorCnName == null ? null : actorCnName,
        // ignore: prefer_if_null_operators
        "actor_en_name": actorEnName == null ? null : actorEnName,
        // ignore: prefer_if_null_operators
        "actor_photos": actorPhotos == null ? null : actorPhotos,
    };
}


// import 'dart:convert';

// List<Movie> movieFromJson(String str) => List<Movie>.from(json.decode(str).map((x) => Movie.fromJson(x)));

// String movieToJson(List<Movie> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class Movie {
//     Movie({
//         this.movieId,
//         this.movieCnName,
//         this.movieEnName,
//         this.movieRating,
//         this.releaseMovieTime,
//         this.movieTrailer,
//         this.moviePoster,
//         this.moviePhotos,
//         this.movieIntroduction,
//         this.actors,
//         this.locationsWithMovietimes,
//     });

//     String movieId;
//     String movieCnName;
//     String movieEnName;
//     String movieRating;
//     String releaseMovieTime;
//     String movieTrailer;
//     String moviePoster;
//     List<String> moviePhotos;
//     String movieIntroduction;
//     List<Actor> actors;
//     Map<String, LocationsWithMovietime> locationsWithMovietimes;

//     factory Movie.fromJson(Map<String, dynamic> json) => Movie(
//         movieId: json["movie_id"],
//         movieCnName: json["movie_cn_name"],
//         movieEnName: json["movie_en_name"],
//         movieRating: json["movie_rating"],
//         releaseMovieTime: json["release_movie_time"],
//         movieTrailer: json["movie_trailer"],
//         moviePoster: json["movie_poster"],
//         moviePhotos: List<String>.from(json["movie_photos"].map((x) => x)),
//         movieIntroduction: json["movie_introduction"],
//         actors: List<Actor>.from(json["actors"].map((x) => Actor.fromJson(x))),
//         locationsWithMovietimes: Map.from(json["locations_with_movietimes"]).map((k, v) => MapEntry<String, LocationsWithMovietime>(k, LocationsWithMovietime.fromJson(v))),
//     );

//     Map<String, dynamic> toJson() => {
//         "movie_id": movieId,
//         "movie_cn_name": movieCnName,
//         "movie_en_name": movieEnName,
//         "movie_rating": movieRating,
//         "release_movie_time": releaseMovieTime,
//         "movie_trailer": movieTrailer,
//         "movie_poster": moviePoster,
//         "movie_photos": List<dynamic>.from(moviePhotos.map((x) => x)),
//         "movie_introduction": movieIntroduction,
//         "actors": List<dynamic>.from(actors.map((x) => x.toJson())),
//         "locations_with_movietimes": Map.from(locationsWithMovietimes).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
//     };
// }

// class Actor {
//     Actor({
//         this.actorCnName,
//         this.actorEnName,
//         this.actorPhotos,
//     });

//     String actorCnName;
//     String actorEnName;
//     String actorPhotos;

//     factory Actor.fromJson(Map<String, dynamic> json) => Actor(
//         actorCnName: json["actor_cn_name"] == null ? null : json["actor_cn_name"],
//         actorEnName: json["actor_en_name"] == null ? null : json["actor_en_name"],
//         actorPhotos: json["actor_photos"] == null ? null : json["actor_photos"],
//     );

//     Map<String, dynamic> toJson() => {
//         "actor_cn_name": actorCnName == null ? null : actorCnName,
//         "actor_en_name": actorEnName == null ? null : actorEnName,
//         "actor_photos": actorPhotos == null ? null : actorPhotos,
//     };
// }

// class LocationsWithMovietime {
//     LocationsWithMovietime({
//         this.location,
//         this.theater,
//     });

//     Location location;
//     List<Map<String, List<String>>> theater;

//     factory LocationsWithMovietime.fromJson(Map<String, dynamic> json) => LocationsWithMovietime(
//         location: locationValues.map[json["location"]],
//         theater: List<Map<String, List<String>>>.from(json["theater"].map((x) => Map.from(x).map((k, v) => MapEntry<String, List<String>>(k, List<String>.from(v.map((x) => x)))))),
//     );

//     Map<String, dynamic> toJson() => {
//         "location": locationValues.reverse[location],
//         "theater": List<dynamic>.from(theater.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x)))))),
//     };
// }

// enum Location { EMPTY, LOCATION }

// final locationValues = EnumValues({
//     "新北市": Location.EMPTY,
//     "台北市": Location.LOCATION
// });

// class EnumValues<T> {
//     Map<String, T> map;
//     Map<T, String> reverseMap;

//     EnumValues(this.map);

//     Map<T, String> get reverse {
//         if (reverseMap == null) {
//             reverseMap = map.map((k, v) => new MapEntry(v, k));
//         }
//         return reverseMap;
//     }
// }
