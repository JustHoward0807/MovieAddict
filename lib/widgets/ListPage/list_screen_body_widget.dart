import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieaddict/models/movie.dart';
import 'package:movieaddict/screens/DetailsPage/details_screen.dart';
import 'package:movieaddict/styles/color.dart';
import 'package:provider/provider.dart';

class ListScreenBodyWidget extends StatelessWidget {
  const ListScreenBodyWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Movie> movies = Provider.of<List<Movie>>(context);
    final size = MediaQuery.of(context).size;
    return (movies != null)
        ? SizedBox(
            width: size.width,
            height: size.height,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: movies.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 150,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, __, ___) => DetailsScreen(
                                    moviePoster: movies[index].moviePoster,
                                    moviePhotos: movies[index].moviePhotos,
                                    movieCnName: movies[index].movieCnName,
                                    movieEnName: movies[index].movieEnName,
                                    movieRating: movies[index].movieRating,
                                    releaseMovieTime:
                                        movies[index].releaseMovieTime,
                                    movieImdbRating:
                                        movies[index].movieImdbRating,
                                    movieDuration: movies[index].movieDuration,
                                    movieCategory: movies[index].movieCategory,
                                    actors: movies[index].actors,
                                    movieTrailer: movies[index].movieTrailer,
                                    movieIntroduction:
                                        movies[index].movieIntroduction,
                                    relatedMovieList: movies,
                                    movieId: movies[index].movieId,
                                  ))),
                      child: Center(
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            ShaderMask(
                                shaderCallback: (bounds) =>
                                    const LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [mainDarkColor, Colors.white],
                                    ).createShader(bounds),
                                child: Container(
                                  width: 105,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color(0xff000000),
                                          offset: Offset(2, 4),
                                          blurRadius: 4.0,
                                          spreadRadius: -3),
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
                                          movies[index].moviePoster,
                                        )),
                                  ),
                                )),
                            Container(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                  right: 5,
                                ),
                                width: 100,
                                height: 50,
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movies[index].movieCnName,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                      Text(
                                        movies[index].movieEnName,
                                        style: GoogleFonts.orbitron(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    );
                  }),
            ))
        : Container();
  }
}
