import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieaddict/models/hive_model.dart';
import 'package:movieaddict/models/movie.dart';
import 'package:movieaddict/screens/DetailsPage/details_screen.dart';
import 'package:movieaddict/services/hive_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

final myListKey = GlobalKey<AnimatedListState>();

class WatchLaterScreen extends StatelessWidget {
  const WatchLaterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15)),
          ),
          title: Text(AppLocalizations.of(context).watchLaterAppBar,
              style: GoogleFonts.montserrat(
                  color: Theme.of(context).focusColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w500)),
          centerTitle: true,
        ),
        preferredSize: Size(size.width, size.height / 11),
      ),
      body: const WatchLaterScreenBody(),
    );
  }
}

class WatchLaterScreenBody extends StatefulWidget {
  const WatchLaterScreenBody({Key key}) : super(key: key);

  @override
  _WatchLaterScreenBodyState createState() => _WatchLaterScreenBodyState();
}

class _WatchLaterScreenBodyState extends State<WatchLaterScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        width: 335,
        child: ValueListenableBuilder(
            valueListenable: HiveService.getMovieBox().listenable(),
            builder: (context, box, _) {
              final boxValueCast = box.values.toList().cast<HiveModel>();
              final boxKeysCast = box.keys.toList().cast<int>();

              return (boxValueCast.length != 0)
                  ? AnimatedList(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      key: myListKey,
                      initialItemCount: boxValueCast.length,
                      itemBuilder: ((context, index, animation) {
                        return BuildAnimatedList(
                            index: index,
                            animation: animation,
                            boxValueCast: boxValueCast,
                            boxKeysCast: boxKeysCast);
                      }))
                  : Center(
                      child: Text(
                      AppLocalizations.of(context).watchLaterNoCollection,
                      style: GoogleFonts.montserrat(
                        color: Theme.of(context).focusColor,
                        fontSize: 14,
                      ),
                    ));
            }),
      ),
    );
  }
}

class BuildAnimatedList extends StatelessWidget {
  final int index;
  final Animation<double> animation;
  final dynamic boxValueCast, boxKeysCast;
  const BuildAnimatedList({
    Key key,
    this.index,
    this.animation,
    this.boxKeysCast,
    this.boxValueCast,
  }) : super(key: key);

  void deleteItem(index) {
    debugPrint('index: $index');
    boxKeysCast.removeAt(index);
    boxValueCast.removeAt(index);
    myListKey.currentState.removeItem(
      index,
      (context, animation) => BuildAnimatedList(
          index: index,
          animation: animation,
          boxKeysCast: boxKeysCast,
          boxValueCast: boxValueCast),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Movie> movies = Provider.of<List<Movie>>(context);
    final Size size = MediaQuery.of(context).size;
    return SlideTransition(
      position: animation.drive(Tween(
        begin: const Offset(1, 0),
        end: const Offset(0, 0),
      ).chain(CurveTween(curve: Curves.easeInOutBack))),
      child: GestureDetector(
        // ignore: void_checks
        onTap: () {
          return Navigator.push(
              context,
              PageRouteBuilder(
                  pageBuilder: (_, __, ___) => DetailsScreen(
                      moviePoster: boxValueCast[index].moviePoster,
                      moviePhotos: boxValueCast[index].moviePhotos,
                      movieCnName: boxValueCast[index].movieCnName,
                      movieEnName: boxValueCast[index].movieEnName,
                      movieRating: boxValueCast[index].movieRating,
                      releaseMovieTime: boxValueCast[index].releaseMovieTime,
                      movieImdbRating: boxValueCast[index].movieImdbRating,
                      movieDuration: boxValueCast[index].movieDuration,
                      movieCategory: boxValueCast[index].movieCategory,
                      actors: boxValueCast[index].actors,
                      movieTrailer: boxValueCast[index].movieTrailer,
                      movieIntroduction: boxValueCast[index].movieIntroduction,
                      movieId: boxValueCast[index].movieId,
                      relatedMovieList: movies)));
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Container(
            height: 165,
            decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xff000000),
                      offset: Offset(0, 4),
                      blurRadius: 4.0,
                      spreadRadius: -3),
                ]),
            child: Row(
              children: [
                //Image Movie Poster
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        Container(
                          width: size.width / 2,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            boxShadow: const [
                              BoxShadow(
                                  color: Color(0xff000000),
                                  offset: Offset(0, 4),
                                  blurRadius: 4.0,
                                  spreadRadius: -4),
                            ],
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                fit: BoxFit.fitWidth,
                                image: NetworkImage(
                                  '${boxValueCast[index].moviePoster}',
                                )),
                          ),
                        ),
                        Positioned(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: const Color(0xffF5F5F5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.bookmark_rounded,
                                  color: Color(0xff252E2C),
                                  size: 20,
                                ),
                                onPressed: () {
                                  deleteMovieWatchLater(
                                      hiveKey: boxKeysCast[index]);
                                  AnimatedList.of(context).removeItem(
                                      index,
                                      (context, animation) => BuildAnimatedList(
                                            index: index,
                                            animation: animation,
                                            boxKeysCast: boxKeysCast,
                                            boxValueCast: boxValueCast,
                                          ));
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //Movie Detail information
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: Center(
                              child: Text(
                                '${boxValueCast[index].movieCnName}',
                                style: GoogleFonts.orbitron(
                                    color: Theme.of(context).focusColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Center(
                              child: Text(
                                '${boxValueCast[index].movieEnName}',
                                softWrap: false,
                                style: GoogleFonts.orbitron(
                                    color: Theme.of(context).focusColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.yahoo,
                                  size: 25,
                                  color: Color(0xff430297),
                                ),
                                Text('${boxValueCast[index].movieRating} / 5.0',
                                    style: GoogleFonts.montserratAlternates(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).focusColor)),
                                const FaIcon(
                                  FontAwesomeIcons.imdb,
                                  size: 27,
                                  color: Color(0xfff5de50),
                                ),
                                (boxValueCast[index].movieImdbRating != '')
                                    ? Text(
                                        '${boxValueCast[index].movieImdbRating} / 10.0',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color:
                                                Theme.of(context).focusColor))
                                    : Text('NULL / 10.0',
                                        style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xffF9F9F9)))
                              ],
                            ),
                          ),
                          Divider(
                            color: Theme.of(context).errorColor,
                          ),
                          Flexible(
                            flex: 2,
                            child: SingleChildScrollView(
                                child: Text(
                                    '${boxValueCast[index].movieIntroduction}',
                                    style: GoogleFonts.notoSans(
                                        fontSize: 13,
                                        color: Theme.of(context).focusColor,
                                        fontWeight: FontWeight.w500))),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
