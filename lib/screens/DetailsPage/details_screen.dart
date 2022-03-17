import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movieaddict/widgets/DetailsPage/details_actors_widget.dart';
import 'package:movieaddict/widgets/DetailsPage/details_introduction_widget.dart';
import 'package:movieaddict/widgets/DetailsPage/details_movie_photos_widget.dart';
import 'package:movieaddict/widgets/DetailsPage/details_movie_time_widget.dart';
import 'package:movieaddict/widgets/DetailsPage/details_poster_widget.dart';
import 'package:movieaddict/widgets/DetailsPage/details_releated_movies_widget.dart';

// import 'package:movieapp/widgets/switch_button.dart';

class DetailsScreen extends StatelessWidget {
  final String movieCnName,
      movieEnName,
      movieRating,
      releaseMovieTime,
      moviePoster,
      movieImdbRating,
      movieDuration,
      movieTrailer,
      movieIntroduction,
      movieId;

  final List moviePhotos,
      locationsWithMovietimes,
      movieCategory,
      actors,
      relatedMovieList;

  const DetailsScreen(
      {Key key,
      this.movieCnName,
      this.movieEnName,
      this.movieRating,
      this.releaseMovieTime,
      this.moviePoster,
      this.moviePhotos,
      this.locationsWithMovietimes,
      this.movieImdbRating,
      this.movieDuration,
      this.movieCategory,
      this.actors,
      this.movieTrailer,
      this.movieIntroduction,
      this.relatedMovieList,
      this.movieId})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DetailsScreenBody(
            moviePoster: moviePoster,
            moviePhotos: moviePhotos,
            movieEnName: movieEnName,
            movieCnName: movieCnName,
            movieRating: movieRating,
            releaseMovieTime: releaseMovieTime,
            movieImdbRating: movieImdbRating,
            movieDuration: movieDuration,
            movieCategory: movieCategory,
            actors: actors,
            movieTrailer: movieTrailer,
            movieIntroduction: movieIntroduction,
            relatedMovieList: relatedMovieList,
            movieId: movieId));
  }
}

// ignore: non_constant_identifier_names
Widget DetailsScreenBody({
  @required moviePoster,
  @required moviePhotos,
  @required movieCnName,
  @required movieEnName,
  @required movieRating,
  @required releaseMovieTime,
  @required movieImdbRating,
  @required movieDuration,
  @required movieCategory,
  @required actors,
  @required movieTrailer,
  @required movieIntroduction,
  relatedMovieList,
  movieId,
}) {
  return Scrollbar(
    isAlwaysShown: true,
    trackVisibility: true,
    thickness: 5,
    radius: const Radius.circular(15),
    interactive: true,
    scrollbarOrientation: ScrollbarOrientation.right,
    child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DetailsPosterWidget(
              moviePoster: moviePoster,
              moviePhotos: moviePhotos,
              movieCnName: movieCnName,
              movieEnName: movieEnName,
              actors: actors,
              movieRating: movieRating,
              releaseMovieTime: releaseMovieTime,
              locationsWithMovietimes: const [],
              movieImdbRating: movieImdbRating,
              movieDuration: movieDuration,
              movieCategory: movieCategory,
              movieTrailer: movieTrailer,
              movieId: movieId,
              movieIntroduction: movieIntroduction,
            ),
            const SizedBox(
              height: 10,
            ),
            DetailsSwitchButton(
              moviePhotos: moviePhotos,
              actors: actors,
              movieIntroduction: movieIntroduction,
              relatedMovieList: relatedMovieList,
              movieCategory: movieCategory,
              movieId: movieId,
            )
          ],
        )),
  );
}

class DetailsSwitchButton extends StatefulWidget {
  final List moviePhotos, actors, movieCategory, relatedMovieList;
  final String movieIntroduction, movieId;
  const DetailsSwitchButton(
      {Key key,
      @required this.moviePhotos,
      @required this.actors,
      @required this.movieIntroduction,
      this.relatedMovieList,
      this.movieCategory,
      this.movieId})
      : super(key: key);

  @override
  _DetailsSwitchButtonState createState() => _DetailsSwitchButtonState();
}

class _DetailsSwitchButtonState extends State<DetailsSwitchButton> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    final Map<dynamic, Widget> switchButton = {
      0: SizedBox(
          width: 165,
          height: 30,
          child: Center(
            child: Text(
              AppLocalizations.of(context).detailsMovieIntroduction,
              style: GoogleFonts.orbitron(
                  fontSize: 14, color: Theme.of(context).focusColor),
            ),
          )),
      1: SizedBox(
          width: 165,
          height: 30,
          child: Center(
            child: Text(
              AppLocalizations.of(context).detailsTime,
              style: GoogleFonts.orbitron(
                  fontSize: 14, color: Theme.of(context).focusColor),
            ),
          )),
    };

    return Column(
      children: [
        CupertinoSegmentedControl(
            padding: const EdgeInsets.only(bottom: 10),
            borderColor: Theme.of(context).scaffoldBackgroundColor,
            unselectedColor: Theme.of(context).secondaryHeaderColor,
            selectedColor: Theme.of(context).primaryColor,
            groupValue: selected,
            children: switchButton,
            onValueChanged: (_value) {
              setState(() {
                selected = _value;
                if (kDebugMode) {
                  print(selected);
                }
              });
            }),
        (selected == 0)
            ? DetailsActorsWidget(
                actors: widget.actors,
              )
            : const SizedBox(),
        (selected == 0)
            ? DetailsMoviePhotosWidget(
                moviePhotos: widget.moviePhotos,
              )
            : const SizedBox(),
        (selected == 0)
            ? DetailsMovieIntroductionWidget(
                movieIntroduction: widget.movieIntroduction,
              )
            : const SizedBox(),
        (selected == 0)
            ? DetailsRelatedMoviesWidget(
                relatedMovieList: widget.relatedMovieList,
                movieCategory: widget.movieCategory)
            : const SizedBox(),
        (selected == 1)
            ? DetailsMovieTimeWidget(
                movie_id: widget.movieId,
              )
            : const SizedBox(),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
