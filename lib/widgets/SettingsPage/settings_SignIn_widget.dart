// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

Widget settingsSignIn({@required radius,@required context, @required onPress}) {
  return Container(
    width: 355,
    height: 80,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:25),
          child: Text(
            AppLocalizations.of(context).settingsSignIn,
            style: GoogleFonts.montserrat(fontSize: 20,color: Theme.of(context).focusColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right:25),
          child: IconButton(
            iconSize: 50,
            onPressed: onPress,
            icon: Icon(Icons.portrait, color: Theme.of(context).errorColor),
          ),
        ),
      ],
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(radius.last)),
      color: Theme.of(context).secondaryHeaderColor,
      boxShadow: const [
        BoxShadow(
            color: Color(0xff000000),
            offset: Offset(2, 2),
            blurRadius: 4.0,
            spreadRadius: -2.0),
      ],
    ),
  );
}
