import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieaddict/screens/DetailsPage/details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movieaddict/styles/color.dart';

class DetailsRelatedMoviesWidget extends StatelessWidget {
  final List relatedMovieList, movieCategory;
  DetailsRelatedMoviesWidget(
      {Key key, this.relatedMovieList, this.movieCategory})
      : super(key: key);
  final List relatedMovie = [];

  void relatedMovieProcess() {
    for (var i = 0; i < relatedMovieList.length; i++) {
      bool isContains = relatedMovieList[i]
          .movieCategory
          .any((e) => movieCategory.contains(e));
      if (isContains) {
        relatedMovie.add(relatedMovieList[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    relatedMovieProcess();
    double length = relatedMovie.length / 2;
    final size = MediaQuery.of(context).size;
    return relatedMovie != null
        ? SizedBox(
            width: size.width,
            height: 230,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  child: Text(
                      '${AppLocalizations.of(context).detailsMore} $movieCategory ${AppLocalizations.of(context).detailsMovies}',
                      style: GoogleFonts.orbitron(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).focusColor)),
                ),
                SizedBox(
                  width: size.width,
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: length.round(),
                      itemBuilder: (BuildContext context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => DetailsScreen(
                                          moviePoster:
                                              relatedMovie[index].moviePoster,
                                          movieCnName:
                                              relatedMovie[index].movieCnName,
                                          moviePhotos:
                                              relatedMovie[index].moviePhotos,
                                          movieEnName:
                                              relatedMovie[index].movieEnName,
                                          movieRating:
                                              relatedMovie[index].movieRating,
                                          releaseMovieTime: relatedMovie[index]
                                              .releaseMovieTime,
                                          movieImdbRating: relatedMovie[index]
                                              .movieImdbRating,
                                          movieDuration:
                                              relatedMovie[index].movieDuration,
                                          movieCategory:
                                              relatedMovie[index].movieCategory,
                                          actors: relatedMovie[index].actors,
                                          movieTrailer:
                                              relatedMovie[index].movieTrailer,
                                          movieIntroduction: relatedMovie[index]
                                              .movieIntroduction,
                                          relatedMovieList: relatedMovieList,
                                          movieId: relatedMovie[index].movieId,
                                        )));
                          },
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [mainDarkColor, Colors.white],
                                ).createShader(bounds),
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  width: 100,
                                  height: 150,
                                  child: CachedNetworkImage(
                                    imageUrl: relatedMovie[index].moviePoster,
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        Center(
                                            child: SizedBox(
                                                width: 25,
                                                height: 25,
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress))),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          alignment: Alignment.center,
                                          fit: BoxFit.cover,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Color(0xff000000),
                                              offset: Offset(1, 4),
                                              blurRadius: 6.0,
                                              spreadRadius: -3),
                                        ],
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(20.0),
                                          topRight: Radius.circular(10.0),
                                          topLeft: Radius.circular(20.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                                height: 40,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        relatedMovie[index].movieCnName,
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        style: GoogleFonts.montserratAlternates(
                                            fontSize: 13,
                                            color: const Color(0xffF9F9F9)),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        relatedMovie[index].movieEnName,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: GoogleFonts.montserratAlternates(
                                            fontSize: 13,
                                            color: const Color(0xffF9F9F9)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          )
        : Container();
  }
}
