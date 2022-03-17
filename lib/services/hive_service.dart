import 'package:hive/hive.dart';
import 'package:movieaddict/models/hive_model.dart';
import 'package:movieaddict/models/movie.dart';

class HiveService {
  static Box<HiveModel> getMovieBox() => Hive.box<HiveModel>('watchlater');
}

void addMovieWatchLater(
    String movieId,
    String movieCnName,
    String movieEnName,
    String movieRating,
    String movieImdbRating,
    String movieDuration,
    List<String> movieCategory,
    String releaseMovieTime,
    String movieTrailer,
    String moviePoster,
    List<String> moviePhotos,
    String movieIntroduction,
    List<Actor> actors) {
  final movieWatchLater = HiveModel()
    ..movieId = movieId
    ..movieCnName = movieCnName
    ..movieEnName = movieEnName
    ..movieRating = movieRating
    ..movieImdbRating = movieImdbRating
    ..movieDuration = movieDuration
    ..movieCategory = movieCategory
    ..releaseMovieTime = releaseMovieTime
    ..movieTrailer = movieTrailer
    ..moviePoster = moviePoster
    ..moviePhotos = moviePhotos
    ..movieIntroduction = movieIntroduction
    ..actors = actors;

  final movieWatchLaterBox = HiveService.getMovieBox();
  movieWatchLaterBox.add(movieWatchLater);
}

void deleteMovieWatchLater({hiveKey}) {
  final movieWatchLaterBox = HiveService.getMovieBox();
  final Map<dynamic, HiveModel> searchKeyMap = movieWatchLaterBox.toMap();
  dynamic myKey;

  searchKeyMap.forEach((key, value) {
    if (key == hiveKey) {
      myKey = key;
    }
  });

  movieWatchLaterBox.delete(myKey);
}
