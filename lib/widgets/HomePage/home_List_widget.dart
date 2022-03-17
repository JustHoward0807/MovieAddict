// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieaddict/screens/DetailsPage/details_screen.dart';
import 'package:movieaddict/styles/color.dart';

class HomeListWidget extends StatelessWidget {
  final double poster_width, poster_height, poster_rating;
  final String poster_movieCnName, poster_movieEnName, poster_ListTitle;
  final List movie_List;
  final bool newMovie;
  const HomeListWidget(
      {Key key,
      @required this.poster_width,
      @required this.poster_height,
      this.poster_rating,
      this.poster_movieCnName,
      this.poster_movieEnName,
      @required this.poster_ListTitle,
      @required this.movie_List,
      @required this.newMovie})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return movie_List != null
        ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      poster_ListTitle.toUpperCase(),
                      style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).focusColor),
                    ),
                    // Text(
                    //   'show all...',
                    //   style: GoogleFonts.montserrat(
                    //       fontSize: 12, color: Theme.of(context).hintColor),
                    // )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 13, top: 18, bottom: 20),
                width: size.width,
                //poster height
                height: poster_height,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: movie_List.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, __, ___) => DetailsScreen(
                                    moviePoster: movie_List[index].moviePoster,
                                    moviePhotos: movie_List[index].moviePhotos,
                                    movieCnName: movie_List[index].movieCnName,
                                    movieEnName: movie_List[index].movieEnName,
                                    movieRating: movie_List[index].movieRating,
                                    releaseMovieTime:
                                        movie_List[index].releaseMovieTime,
                                    movieImdbRating:
                                        movie_List[index].movieImdbRating,
                                    movieDuration:
                                        movie_List[index].movieDuration,
                                    movieCategory:
                                        movie_List[index].movieCategory,
                                    actors: movie_List[index].actors,
                                    movieTrailer:
                                        movie_List[index].movieTrailer,
                                    movieIntroduction:
                                        movie_List[index].movieIntroduction,
                                    relatedMovieList: movie_List,
                                    movieId: movie_List[index].movieId,
                                  ))),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 17),
                        child: Stack(
                          children: [
                            newMovie != true
                                ? ShaderMask(
                                    shaderCallback: (bounds) =>
                                        const LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [mainDarkColor, Colors.white],
                                    ).createShader(bounds),
                                    child: HomeMovieListPoster(
                                        poster_width: poster_width,
                                        movie_List: movie_List,
                                        index: index),
                                  )
                                : HomeMovieListPoster(
                                    poster_width: poster_width,
                                    movie_List: movie_List,
                                    index: index),
                            newMovie != true
                                ? Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: SizedBox(
                                          width: 130,
                                          height: 70,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    const FaIcon(
                                                      FontAwesomeIcons.yahoo,
                                                      size: 20,
                                                      color: Color(0xff430297),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                          '${movie_List[index].movieRating} / 5.0',
                                                          style: GoogleFonts
                                                              .montserratAlternates(
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: const Color(
                                                                      0xffF9F9F9))),
                                                    ),
                                                    const FaIcon(
                                                      FontAwesomeIcons.imdb,
                                                      size: 20,
                                                      color: Color(0xfff5de50),
                                                    ),
                                                    ('${movie_List[index].movieImdbRating}' !=
                                                            '')
                                                        ? Expanded(
                                                            child: Text(
                                                                '${movie_List[index].movieImdbRating} / 10.0',
                                                                style: GoogleFonts.montserratAlternates(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: const Color(
                                                                        0xffF9F9F9))),
                                                          )
                                                        : Expanded(
                                                            child: Text(
                                                                'NULL / 10.0',
                                                                style: GoogleFonts.montserratAlternates(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: const Color(
                                                                        0xffF9F9F9))),
                                                          )
                                                  ],
                                                ),
                                                Text(
                                                  '${movie_List[index].movieCnName}',
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  '${movie_List[index].movieEnName}',
                                                  style: GoogleFonts.orbitron(
                                                      fontSize: 14,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ))
                                : Container()
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        : Container();
  }
}

class HomeMovieListPoster extends StatelessWidget {
  const HomeMovieListPoster(
      {Key key,
      @required this.poster_width,
      @required this.movie_List,
      @required this.index})
      : super(key: key);

  final double poster_width;
  final List movie_List;
  final int index;

  @override
  Widget build(BuildContext context) {
    return movie_List[index].moviePoster != null
        ? Container(
            width: poster_width,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Color(0xff000000),
                    offset: Offset(5, 5),
                    blurRadius: 4.0,
                    spreadRadius: -4),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(25.0),
              ),
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(
                    '${movie_List[index].moviePoster}',
                  )),
            ),
          )
        : const Center(child: Text('CANNOT READ IMAGE'));
  }
}
