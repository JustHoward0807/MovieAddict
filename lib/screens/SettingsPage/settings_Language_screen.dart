import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieaddict/services/languageProvider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsLanguageSwitch extends StatelessWidget {
  final List<double> radius = [15, 25];

  SettingsLanguageSwitch({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(size.width, size.height / 11),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).focusColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(radius.first),
                bottomLeft: Radius.circular(radius.first)),
          ),
          title: Text(AppLocalizations.of(context).settingsLanguage,
              style: GoogleFonts.montserrat(
                  color: Theme.of(context).focusColor, fontSize: 24)),
          centerTitle: true,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () =>
                  context.read<LanguageProvider>().changeLocale("zh"),
              child: const Text('中文'),
            ),
            TextButton(
              onPressed: () =>
                  context.read<LanguageProvider>().changeLocale("en"),
              child: const Text('English'),
            ),
          ],
        ),
      ),
    );
  }
}
