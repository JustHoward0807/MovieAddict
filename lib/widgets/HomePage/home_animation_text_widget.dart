import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAnimationTextWidget extends StatefulWidget {
  final String movieName;

  const HomeAnimationTextWidget({Key key, @required this.movieName})
      : super(key: key);

  @override
  _HomeAnimationTextWidgetState createState() =>
      _HomeAnimationTextWidgetState();
}

class _HomeAnimationTextWidgetState extends State<HomeAnimationTextWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (Widget child, Animation animation) {
        return SlideTransition(
          child: child,
          position:
              Tween<Offset>(begin: const Offset(-7, 0), end: const Offset(0, 0))
                  .animate(animation),
        );
      },
      child: Text(widget.movieName,
          key: ValueKey<String>(widget.movieName),
          overflow: TextOverflow.fade,
          style: GoogleFonts.orbitron(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).focusColor)),
    );
  }
}
