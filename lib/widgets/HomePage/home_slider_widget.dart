import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieaddict/screens/DetailsPage/details_screen.dart';
import 'package:movieaddict/widgets/HomePage/home_animation_text_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeSliderWidget extends StatefulWidget {
  final List sliderMoviesList;
  final List relatedMovieList;
  const HomeSliderWidget(
      {Key key, @required this.sliderMoviesList, this.relatedMovieList})
      : super(key: key);
  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  int currentPageValue = 0;
  Color _color;
  final List<Color> _categoryColorList = [];

  void movieCategoryColor(List movieCategory) {
    for (var movie = 0; movie < movieCategory.length; movie++) {
      switch (movieCategory[movie]) {
        case '動畫':
          _color = Colors.purple;
          _categoryColorList.add(_color);
          continue;
        case '紀錄片':
          _color = Colors.green;
          _categoryColorList.add(_color);
          continue;
        case '愛情':
          _color = Colors.pink;
          _categoryColorList.add(_color);
          continue;
        case '喜劇':
          _color = Colors.yellow;
          _categoryColorList.add(_color);
          continue;
        case '科幻':
        case '奇幻':
          _color = Colors.blue[900];
          _categoryColorList.add(_color);
          continue;

        case '動作':
        case '冒險':
          _color = Colors.orange;
          _categoryColorList.add(_color);
          continue;
        case '懸疑/驚悚':
        case '犯罪':
        case '戰爭':
          _color = Colors.black87;
          _categoryColorList.add(_color);
          continue;

        case '恐怖':
          _color = Colors.red;
          _categoryColorList.add(_color);
          continue;
        default:
          _color = const Color(0xff9B9B9B);
          _categoryColorList.add(_color);
      }
    }
  }

  Future<void> _launchInBrowser(String url) async {
    final bool nativeAppLaunchSucceeded = await launch(
      url,
      forceSafariVC: false,
      universalLinksOnly: true,
    );
    if (!nativeAppLaunchSucceeded) {
      await launch(
        url,
        forceSafariVC: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int index;
    return (widget.sliderMoviesList == null)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(children: [
            SizedBox(
              width: size.width,
              // height: 350,
              child: Stack(alignment: Alignment.bottomRight, children: [
                CarouselSlider.builder(
                  itemCount: (widget.sliderMoviesList.length > 5)
                      ? 5
                      : widget.sliderMoviesList.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int unKnownIndex) {
                    index = itemIndex;
                    return GestureDetector(
                      // ignore: void_checks
                      onTap: () {
                        return Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (_, __, ___) => DetailsScreen(
                                      moviePoster: widget
                                          .sliderMoviesList[itemIndex]
                                          .moviePoster,
                                      moviePhotos: widget
                                          .sliderMoviesList[itemIndex]
                                          .moviePhotos,
                                      movieCnName: widget
                                          .sliderMoviesList[itemIndex]
                                          .movieCnName,
                                      movieEnName: widget
                                          .sliderMoviesList[itemIndex]
                                          .movieEnName,
                                      movieRating: widget
                                          .sliderMoviesList[itemIndex]
                                          .movieRating,
                                      releaseMovieTime: widget
                                          .sliderMoviesList[itemIndex]
                                          .releaseMovieTime,
                                      movieImdbRating: widget
                                          .sliderMoviesList[itemIndex]
                                          .movieImdbRating,
                                      movieDuration: widget
                                          .sliderMoviesList[itemIndex]
                                          .movieDuration,
                                      movieCategory: widget
                                          .sliderMoviesList[itemIndex]
                                          .movieCategory,
                                      actors: widget
                                          .sliderMoviesList[itemIndex].actors,
                                      movieTrailer: widget
                                          .sliderMoviesList[itemIndex]
                                          .movieTrailer,
                                      movieIntroduction: widget
                                          .sliderMoviesList[itemIndex]
                                          .movieIntroduction,
                                      relatedMovieList: widget.relatedMovieList,
                                      movieId: widget
                                          .sliderMoviesList[itemIndex].movieId,
                                    )));
                      },
                      child: SizedBox(
                        width: size.width,
                        child: Hero(
                          tag: '${widget.sliderMoviesList[itemIndex].movieId}',
                          child: Image.network(
                            '${widget.sliderMoviesList[itemIndex].moviePoster}',
                            fit: BoxFit.cover,
                            alignment: FractionalOffset.topCenter,
                          ),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentPageValue = index;
                        // print('current poster page is ${currentPageValue}');
                      });
                    },
                    viewportFraction: 1,
                    aspectRatio: 1,
                    autoPlayCurve: Curves.linearToEaseOut,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 10),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xff000000),
                            offset: Offset(1, 4),
                            blurRadius: 4.0,
                            spreadRadius: -1),
                      ],
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                    width: 135,
                    height: 41,
                    child: TextButton(
                      onPressed: () {
                        _launchInBrowser(
                            widget.sliderMoviesList[index].movieTrailer);
                      },
                      child: Text(
                        AppLocalizations.of(context).btnPlayTrailer,
                        style: GoogleFonts.montserrat(
                            color: Theme.of(context).focusColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Container(
              width: size.width,
              height: 135,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xff000000),
                      offset: Offset(2, 2),
                      blurRadius: 4.0,
                      spreadRadius: -2.0),
                ],
                color: Theme.of(context).secondaryHeaderColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 6),
                  AnimatedSmoothIndicator(
                    count: (widget.sliderMoviesList.length > 5)
                        ? 5
                        : widget.sliderMoviesList.length,
                    activeIndex: currentPageValue,
                    effect: WormEffect(
                        spacing: 10.0,
                        dotWidth: 8.0,
                        dotHeight: 8.0,
                        dotColor: Theme.of(context).errorColor,
                        activeDotColor: Theme.of(context).primaryColor),
                  ),
                  SizedBox(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 5),
                              child: SizedBox(
                                width: 223,
                                height: 50,
                                // color: Colors.white,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      HomeAnimationTextWidget(
                                          movieName: widget
                                              .sliderMoviesList[
                                                  currentPageValue]
                                              .movieCnName),
                                      HomeAnimationTextWidget(
                                          movieName: widget
                                              .sliderMoviesList[
                                                  currentPageValue]
                                              .movieEnName),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: SizedBox(
                                width: 223,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RatingBar.builder(
                                        ignoreGestures: true,
                                        itemSize: 20,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        initialRating: double.parse(widget
                                            .sliderMoviesList[currentPageValue]
                                            .movieRating),
                                        itemBuilder: (context, _) {
                                          return Icon(
                                            Icons.local_movies_rounded,
                                            color: Theme.of(context).hoverColor,
                                          );
                                        },
                                        unratedColor: const Color(0xff9B9B9B),
                                        onRatingUpdate: (_) {
                                          return null;
                                        }),
                                    // Text('See More...',
                                    //     style: GoogleFonts.montserrat(
                                    //         fontSize: 10,
                                    //         color: Theme.of(context).hintColor,
                                    //         decoration:
                                    //             TextDecoration.underline)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),

                        //TODOChange movie category in the future in better efficient method.
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: SizedBox(
                            // color: Colors.black,
                            width: 100,
                            height: 100,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: widget
                                    .sliderMoviesList[currentPageValue]
                                    .movieCategory
                                    .length,
                                itemBuilder: (context, index) {
                                  movieCategoryColor(widget
                                      .sliderMoviesList[index].movieCategory);

                                  return Container(
                                    width: 55,
                                    height: 50,
                                    margin: const EdgeInsets.only(bottom: 10),
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color(0xff000000),
                                            offset: Offset(2, 2),
                                            blurRadius: 4.0,
                                            spreadRadius: -2.0),
                                      ],
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${widget.sliderMoviesList[currentPageValue].movieCategory[index]}',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14,
                                            color:
                                                Theme.of(context).focusColor),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]);
  }
}
