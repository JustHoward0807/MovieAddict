import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movieaddict/models/movie.dart';
import 'package:movieaddict/services/admob_service.dart';
import 'package:movieaddict/widgets/HomePage/home_List_widget.dart';
import 'package:movieaddict/widgets/HomePage/home_slider_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  final List popularMovieList = [];
  final List newestMovieList = [];
  final List sliderMovieList = [];

  HomeScreen({Key key}) : super(key: key);
  void filterList(movies, double rating, double imdbRating, List movieList) {
    try {
      for (var i = 0; i < movies.length; i++) {
        if (movies[i].movieImdbRating != "") {
          if (double.parse(movies[i].movieRating) > rating ||
              double.parse(movies[i].movieImdbRating) > imdbRating) {
            movieList.add(movies[i]);
            movieList.shuffle();
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void movieNewestList(movies, List movieList, DateTime currentTime) {
    try {
      for (var i = 0; i < movies.length; i++) {
        movieList.add(movies);
        movieList.sort(
            (a, b) => a[i].releaseMovieTime.compareTo(b[i].releaseMovieTime));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // void sliderList(movies, double rating, double imdbRating, List movieList) {
  //   try {
  //     for (var i = 0; i < movies.length; i++) {
  //       if (movies[i].movieImdbRating != "") {
  //         if (double.parse(movies[i].movieRating) > rating ||
  //             double.parse(movies[i].movieImdbRating) > imdbRating) {
  //           movieList.add(movies[i]);
  //           // movieList2.shuffle();
  //         }
  //       }
  //     }
  //   } catch (e) {}
  // }

  @override
  Widget build(BuildContext context) {
    List<Movie> movies = Provider.of<List<Movie>>(context);

    return Scaffold(
      body: Builder(builder: (context) {
        filterList(movies, 4.0, 7.0, sliderMovieList);
        filterList(movies, 3.0, 6.0, popularMovieList);
        movieNewestList(movies, newestMovieList, DateTime.now());
        return HomeScreenBody(
          movies: movies,
          popularMovieList: popularMovieList,
          newestMovieList: newestMovieList,
          sliderMovieList: sliderMovieList,
        );
      }),
    );
  }
}

class HomeScreenBody extends StatefulWidget {
  final List movies;
  final List popularMovieList;
  final List newestMovieList;
  final List sliderMovieList;
  const HomeScreenBody(
      {Key key,
      this.movies,
      this.popularMovieList,
      this.newestMovieList,
      this.sliderMovieList})
      : super(key: key);
  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  final adService = AdService();
  @override
  void didChangeDependencies() {
    adService.bannerAd.load();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return widget.movies != null
        ? SingleChildScrollView(
            child: Column(
              children: [
                HomeSliderWidget(
                  sliderMoviesList: widget.sliderMovieList,
                  relatedMovieList: widget.movies,
                ),
                widget.popularMovieList != null
                    ? HomeListWidget(
                        poster_width: 150,
                        poster_height: 200,
                        poster_ListTitle:
                            AppLocalizations.of(context).homePopularMovie,
                        movie_List: widget.popularMovieList,
                        poster_movieCnName: '',
                        poster_movieEnName: '',
                        poster_rating: null,
                        newMovie: false,
                      )
                    : const CircularProgressIndicator(),
                HomeListWidget(
                  poster_width: 100,
                  poster_height: 150,
                  poster_ListTitle: AppLocalizations.of(context).homeNewMovie,
                  movie_List: widget.newestMovieList[0],
                  newMovie: true,
                ),
                Container(
                  alignment: Alignment.center,
                  child: AdWidget(ad: adService.bannerAd),
                  width: adService.bannerAd.size.width.toDouble(),
                  height: adService.bannerAd.size.height.toDouble(),
                )
              ],
            ),
          )
        : const Center(child: LinearProgressIndicator());
  }
}
