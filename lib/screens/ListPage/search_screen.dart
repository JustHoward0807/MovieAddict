import 'package:flutter/material.dart';
import 'package:movieaddict/models/movie.dart';
import 'package:movieaddict/screens/DetailsPage/details_screen.dart';
import 'package:movieaddict/styles/color.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchList extends SearchDelegate {
  String hintText;
  @override
  String get searchFieldLabel {
    return hintText;
  } //searchFieldStyle

  @override
  ThemeData appBarTheme(BuildContext context) {
    hintText = AppLocalizations.of(context).listSearchHintText;
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      primaryColor: mainDarkColor,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white70),
      textTheme: theme.textTheme.copyWith(
        headline6:
            const TextStyle(fontWeight: FontWeight.normal, color: Colors.white),
      ),
      // inputDecorationTheme: InputDecorationTheme(
      //     hintStyle: Theme.of(context).textTheme.subtitle1
      //     // .copyWith(color: Theme.of(context).focusColor),
      //     )
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.cancel,
          color: Theme.of(context).focusColor,
        ),
        tooltip: 'Clear',
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).focusColor,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Movie> movies = Provider.of<List<Movie>>(context);
    final suggests = movies
        .where((suggest) => (suggest.movieEnName + ' ' + suggest.movieCnName)
            .toLowerCase()
            .contains(query))
        .toList();

    if (movies == null) {
      return const Center(
        child: Text('No movies'),
      );
    }
    return ListView(
        children: (suggests != null)
            ? suggests
                .map(
                  (e) => buildSuggestListTile(e, context, movies),
                )
                .toList()
            : Container());
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Movie> movies = Provider.of<List<Movie>>(context);
    final results = movies
        .where((result) =>
            (result.movieEnName + ' ' + result.movieCnName).contains(query))
        .toList();
    if (movies == null) {
      return const Center(
        child: Text('No movies'),
      );
    }
    return ListView(
        children: (results != null)
            ? results
                .map(
                  (e) => buildSuggestListTile(e, context, movies),
                )
                .toList()
            : Container());
  }

  ListTile buildSuggestListTile(Movie e, context, List movies) {
    return ListTile(
      title: Text(
        e.movieEnName,
        style: TextStyle(color: Theme.of(context).focusColor),
      ),
      subtitle: Text(
        e.movieCnName,
        style: TextStyle(color: Theme.of(context).focusColor),
      ),
      trailing: Image.network(e.moviePoster),
      onTap: () {
        query = e.movieEnName + ' ' + e.movieCnName;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreen(
                      moviePoster: e.moviePoster,
                      moviePhotos: e.moviePhotos,
                      movieCnName: e.movieCnName,
                      movieEnName: e.movieEnName,
                      movieRating: e.movieRating,
                      releaseMovieTime: e.releaseMovieTime,
                      movieImdbRating: e.movieImdbRating,
                      movieDuration: e.movieDuration,
                      movieCategory: e.movieCategory,
                      actors: e.actors,
                      movieTrailer: e.movieTrailer,
                      movieIntroduction: e.movieIntroduction,
                      relatedMovieList: movies,
                      movieId: e.movieId,
                    )));
      },
    );
  }
}
