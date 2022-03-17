import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieaddict/screens/WatchLaterPage/watch_later_screen.dart';
import 'package:movieaddict/services/hive_service.dart';
import 'package:movieaddict/styles/color.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailsPosterWidget extends StatelessWidget {
  final String movieCnName,
      movieEnName,
      movieRating,
      releaseMovieTime,
      moviePoster,
      movieImdbRating,
      movieDuration,
      movieTrailer,
      movieId,
      movieIntroduction;
  final List moviePhotos, actors, locationsWithMovietimes, movieCategory;
  const DetailsPosterWidget(
      {Key key,
      @required this.movieCnName,
      @required this.movieEnName,
      @required this.movieRating,
      @required this.releaseMovieTime,
      @required this.moviePoster,
      @required this.moviePhotos,
      @required this.actors,
      @required this.locationsWithMovietimes,
      @required this.movieImdbRating,
      @required this.movieDuration,
      @required this.movieCategory,
      @required this.movieTrailer,
      @required this.movieId,
      @required this.movieIntroduction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String randomMoviePhoto;
    Color _color;
    List<Color> _categoryColorList = [];

    Future<void> _launch({String url}) async {
      if (!await canLaunch(url)) {
        await launch(
          url,
        );
      } else {
        throw 'Could not launch $url';
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

    void moviePhotosRandomPick(List moviePhotos) {
      var randomItem = moviePhotos;
      randomMoviePhoto = (randomItem..shuffle()).first;
    }

    if (moviePhotos.isNotEmpty) {
      moviePhotosRandomPick(moviePhotos);
    }
    movieCategoryColor(movieCategory);
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        //Background shader image
        GestureDetector(
          onTap: () =>
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return DetailsFullScreen(
              moviePhotos:
                  moviePhotos.isNotEmpty ? moviePhotos[0] : moviePoster,
              tag: '2',
            );
          })),
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [mainDarkColor, Colors.white],
            ).createShader(bounds),
            child: Hero(
              tag: '2',
              child: SizedBox(
                child: CachedNetworkImage(
                  imageUrl:
                      moviePhotos.isNotEmpty ? randomMoviePhoto : moviePoster,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                          child: SizedBox(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress))),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xff000000),
                            offset: Offset(1, 4),
                            blurRadius: 4.0,
                            spreadRadius: -1),
                      ],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                width: size.width,
                height: 412,
              ),
            ),
          ),
        ),
        Positioned(
          top: 30,
          left: 15,
          right: 15,
          child: SizedBox(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Color(0xffF5F5F5),
                  ),
                  iconSize: 30,
                ),
                BookmarkIcon(
                  movieId: movieId,
                  movieCnName: movieCnName,
                  movieEnName: movieEnName,
                  movieRating: movieRating,
                  movieImdbRating: movieImdbRating,
                  movieDuration: movieDuration,
                  movieIntroduction: movieIntroduction,
                  movieTrailer: movieTrailer,
                  moviePoster: moviePoster,
                  releaseMovieTime: releaseMovieTime,
                  movieCategory: movieCategory,
                  moviePhotos: moviePhotos,
                  actors: actors,
                  iconSize: 30,
                  iconColor: const Color(0xffF5F5F5),
                )
              ],
            ),
          ),
        ),

        // Movie information and movie poster
        SizedBox(
          width: size.width,
          height: 297,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                width: size.width / 2 - 10,
                height: 200,
                // color: Colors.orange,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.yahoo,
                          size: 25,
                          color: Color(0xff430297),
                        ),
                        Text('$movieRating / 5.0',
                            style: GoogleFonts.montserratAlternates(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xffF9F9F9))),
                        const FaIcon(
                          FontAwesomeIcons.imdb,
                          size: 25,
                          color: Color(0xfff5de50),
                        ),
                        (movieImdbRating != '')
                            ? Text('$movieImdbRating / 10.0',
                                style: GoogleFonts.montserratAlternates(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xffF9F9F9)))
                            : Text('NULL / 10.0',
                                style: GoogleFonts.montserratAlternates(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xffF9F9F9)))
                      ],
                    ),
                    SizedBox(
                      width: 170,
                      height: 68,
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                movieCnName,
                                style: GoogleFonts.orbitron(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xffF9F9F9),
                                ),
                              ),
                              Text(movieEnName,
                                  style: GoogleFonts.orbitron(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xffF9F9F9)),
                                  softWrap: false),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '片長 : $movieDuration\b',
                      style: GoogleFonts.montserratAlternates(
                          fontSize: 12, color: const Color(0xffF9F9F9)),
                    ),
                    Text(
                      '上映日期 : $releaseMovieTime',
                      style: GoogleFonts.orbitron(
                          fontSize: 12, color: const Color(0xffF9F9F9)),
                    ),
                    SizedBox(
                      width: size.width,
                      height: 55,
                      child: Center(
                        child: ListView.builder(
                            itemCount: movieCategory.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return MovieCategory(
                                  context: context,
                                  index: index,
                                  movieCategory: movieCategory,
                                  color: _categoryColorList);
                            }),
                      ),
                    )
                  ],
                ),
              ),

              //Movie Poster
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Hero(
                      tag: movieId,
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0xff000000),
                                  offset: Offset(2, 1),
                                  blurRadius: 2,
                                  spreadRadius: -3),
                            ],
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            image: DecorationImage(
                              image: (moviePoster != null)
                                  ? NetworkImage(
                                      moviePoster,
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator()),
                            )),
                        margin: const EdgeInsets.only(right: 10),
                        width: size.width / 2,
                        height: 288,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      width: 135,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                        ),
                      ),
                      child: TextButton(
                          onPressed: () {
                            _launchInBrowser(movieTrailer);
                          },
                          child: Text(
                            AppLocalizations.of(context).btnPlayTrailer,
                            style: GoogleFonts.montserrat(
                                color: Theme.of(context).focusColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}

class DetailsFullScreen extends StatelessWidget {
  final String moviePhotos, tag;
  const DetailsFullScreen({@required this.moviePhotos, @required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: tag,
            child: InteractiveViewer(
              child: Image.network(
                moviePhotos,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget MovieCategory(
    {BuildContext context, int index, List movieCategory, List<Color> color}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Container(
        width: (movieCategory[index].length > 2) ? 100 : 50,
        height: 30,
        decoration: BoxDecoration(
          color: color[index],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        padding: const EdgeInsets.all(5),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            movieCategory[index],
            style: GoogleFonts.lato(
                fontSize: 14,
                color: (color[index] == Colors.black87)
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ),
  );
}

class BookmarkIcon extends StatefulWidget {
  final String movieId,
      movieCnName,
      movieEnName,
      movieRating,
      movieImdbRating,
      movieDuration,
      releaseMovieTime,
      movieTrailer,
      moviePoster,
      movieIntroduction;
  final double iconSize;
  final Color iconColor;
  final List<String> movieCategory, moviePhotos;
  final List actors;
  const BookmarkIcon(
      {this.movieId,
      this.movieCnName,
      this.movieEnName,
      this.movieRating,
      this.movieImdbRating,
      this.movieDuration,
      this.releaseMovieTime,
      this.movieTrailer,
      this.moviePoster,
      this.movieIntroduction,
      this.movieCategory,
      this.moviePhotos,
      this.actors,
      this.iconSize,
      this.iconColor});
  @override
  _BookmarkIconState createState() => _BookmarkIconState();
}

class _BookmarkIconState extends State<BookmarkIcon> {
  List valueList = [];
  List keyList = [];
  final myBox = HiveService.getMovieBox();

  @override
  Widget build(BuildContext context) {
    myBox.toMap().forEach((key, value) {
      keyList.add(key);
      valueList.add(value.movieId);
    });
    debugPrint('valueList: $valueList');
    debugPrint('keyList: $keyList');

    return (valueList.contains(widget.movieId))
        ? IconButton(
            onPressed: () {
              setState(() {
                for (var i = 0; i < valueList.length; i++) {
                  if (valueList[i] == widget.movieId) {
                    //TODODialog to delete.
                    valueList.removeAt(i);
                    debugPrint('key element at ${keyList.elementAt(i)}');
                    debugPrint('i at $i');
                    deleteMovieWatchLater(hiveKey: keyList.elementAt(i));
                  }
                }
              });
            },
            icon: Icon(
              Icons.bookmark_rounded,
              color: widget.iconColor,
            ),
            iconSize: widget.iconSize,
          )
        : IconButton(
            onPressed: () {
              setState(() {
                addMovieWatchLater(
                    widget.movieId,
                    widget.movieCnName,
                    widget.movieEnName,
                    widget.movieRating,
                    widget.movieImdbRating,
                    widget.movieDuration,
                    widget.movieCategory,
                    widget.releaseMovieTime,
                    widget.movieTrailer,
                    widget.moviePoster,
                    widget.moviePhotos,
                    widget.movieIntroduction,
                    widget.actors);
                if (keyList.isNotEmpty) {
                  if (myListKey.currentState != null) {
                    myListKey.currentState.insertItem(keyList.length - 1);
                  }
                }

                debugPrint('bookmark success');
              });
            },
            //color: Color(0xffF5F5F5)
            icon: Icon(
              Icons.bookmark_border_rounded,
              color: widget.iconColor,
            ),
            iconSize: widget.iconSize,
          );
  }
}
