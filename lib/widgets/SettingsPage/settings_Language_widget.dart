import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movieaddict/screens/SettingsPage/settings_Language_screen.dart';

class settingsLanguage extends StatefulWidget {
  final int radius;
  const settingsLanguage({this.radius});

  @override
  _settingsLanguageState createState() => _settingsLanguageState();
}

class _settingsLanguageState extends State<settingsLanguage> {
  bool enabled = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => SettingsLanguageSwitch())),
      onTapDown: (TapDownDetails details) {
        setState(() {
          enabled = true;
        });
      },
      onTapCancel: () {
        setState(() {
          enabled = false;
        });
      },
      child: Container(
        width: 345,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).settingsLanguage,
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: Theme.of(context).focusColor,
                  fontWeight: FontWeight.w300),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
              size: 40,
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          color: !enabled
              ? Theme.of(context).secondaryHeaderColor
              : Theme.of(context).buttonColor,
          boxShadow: const [
            BoxShadow(
                color: Color(0xff000000),
                offset: Offset(2, 2),
                blurRadius: 4.0,
                spreadRadius: -2.0),
          ],
        ),
      ),
    );
  }
}
