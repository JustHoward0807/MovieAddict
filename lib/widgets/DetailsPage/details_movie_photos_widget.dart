import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movieaddict/widgets/DetailsPage/details_poster_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailsMoviePhotosWidget extends StatefulWidget {
  final List moviePhotos;
  const DetailsMoviePhotosWidget({this.moviePhotos});

  @override
  _DetailsMoviePhotosWidgetState createState() =>
      _DetailsMoviePhotosWidgetState();
}

class _DetailsMoviePhotosWidgetState extends State<DetailsMoviePhotosWidget> {
  int _currentPageValue = 0;
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return (widget.moviePhotos.isNotEmpty && widget.moviePhotos != null)
        ? SizedBox(
            width: 355,
            height: 165,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CarouselSlider.builder(
                  itemCount: widget.moviePhotos.length,
                  itemBuilder: (BuildContext context, index, int unknown) {
                    return GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailsFullScreen(
                          moviePhotos: widget.moviePhotos[index],
                          tag: '1',
                        );
                      })),
                      child: Hero(
                        tag: '1',
                        child: CachedNetworkImage(
                          imageUrl: widget.moviePhotos[index],
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
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
                                    offset: Offset(2, 2),
                                    blurRadius: 6.0,
                                    spreadRadius: -3),
                              ],
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10.0),
                                bottomRight: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                                topLeft: Radius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentPageValue = index;
                      });
                    },
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 20),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 10.0, right: 5.0),
                      child: AnimatedSmoothIndicator(
                        count: widget.moviePhotos.length,
                        activeIndex: _currentPageValue,
                        effect: ScrollingDotsEffect(
                            radius: 5,
                            strokeWidth: 0,
                            activeStrokeWidth: 0,
                            activeDotScale: 1,
                            fixedCenter: true,
                            spacing: 5.0,
                            dotWidth: 15.0,
                            dotHeight: 5.0,
                            dotColor: const Color(0xff9B9B9B),
                            activeDotColor: Theme.of(context).primaryColor),
                      )),
                ),
              ],
              clipBehavior: Clip.none,
            ))
        : Container();
  }
}
