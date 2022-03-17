import 'package:hive/hive.dart';
import 'package:movieaddict/models/movie.dart';
part 'hive_model.g.dart';

@HiveType(typeId: 0)
class HiveModel extends HiveObject {
  @HiveField(0)
  String movieId;
  @HiveField(1)
  String movieCnName;
  @HiveField(2)
  String movieEnName;
  @HiveField(3)
  String movieRating;
  @HiveField(4)
  String movieImdbRating;
  @HiveField(5)
  String movieDuration;
  @HiveField(6)
  List<String> movieCategory;
  @HiveField(7)
  String releaseMovieTime;
  @HiveField(8)
  String movieTrailer;
  @HiveField(9)
  String moviePoster;
  @HiveField(10)
  List<String> moviePhotos;
  @HiveField(11)
  String movieIntroduction;
  @HiveField(12)
  List<Actor> actors;
}
