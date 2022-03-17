import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailsMovieIntroductionWidget extends StatelessWidget {
  final String movieIntroduction;
  const DetailsMovieIntroductionWidget({Key key, @required this.movieIntroduction}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            
            child: Text(AppLocalizations.of(context).detailsMovieIntroduction,
                style: GoogleFonts.orbitron(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).focusColor)),
          ),
          const SizedBox(
            height: 10,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: MediaQuery.of(context).size.height / 3,
            ),
            child: SingleChildScrollView(
              child: Text(
                movieIntroduction,
                style: GoogleFonts.notoSans(
                    fontSize: 16, color: Theme.of(context).focusColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
