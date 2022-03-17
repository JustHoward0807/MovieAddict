import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieaddict/models/movie.dart';

class DetailsActorsWidget extends StatelessWidget {
  final List<Actor> actors;
  const DetailsActorsWidget({this.actors});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return actors[0].actorCnName != null
        ? Padding(
            padding: const EdgeInsets.only(left: 10.0, bottom: 10),
            child: SizedBox(
              width: size.width,
              height: 122,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: actors.length,
                  itemBuilder: (context, index) {
                    return BuildActors(
                        context: context, index: index, actors: actors);
                  }),
            ),
          )
        : Container();
  }
}

Widget BuildActors({BuildContext context, int index, actors}) {
  return Padding(
    padding: const EdgeInsets.only(right: 15.0),
    child: Column(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: CachedNetworkImage(
            imageUrl: actors[index].actorPhotos != ''
                ? actors[index].actorPhotos
                : 'https://image.pngaaa.com/689/2189689-middle.png',
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress))),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  alignment: Alignment.topCenter,
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
        SizedBox(
            width: 80,
            height: 42,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    actors[index].actorCnName,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        fontSize: 14, color: Theme.of(context).focusColor),
                  ),
                  actors[index].actorCnName != null
                      ? Text(
                          actors[index].actorEnName,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontSize: 14,
                              color: Theme.of(context).focusColor),
                        )
                      : Container()
                ],
              ),
            )),
      ],
    ),
  );
}
