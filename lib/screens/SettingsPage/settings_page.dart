import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movieaddict/screens/SettingsPage/settings_Language_screen.dart';
import 'package:movieaddict/screens/SettingsPage/settings_about_screen.dart';
import 'package:movieaddict/screens/SettingsPage/settings_template_screen.dart';
import 'package:movieaddict/services/admob_service.dart';
import 'package:movieaddict/widgets/SettingsPage/settings_Structure_widget.dart';
import 'package:movieaddict/widgets/SettingsPage/settings_Theme_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final List<double> radius = [15, 25];

class SettingPage extends StatelessWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(radius.first),
                bottomLeft: Radius.circular(radius.first)),
          ),
          title: Text(AppLocalizations.of(context).settingsAppBar,
              style: GoogleFonts.montserrat(
                  color: Theme.of(context).focusColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w500)),
          centerTitle: true,
        ),
        preferredSize: Size(size.width, size.height / 11),
      ),
      body: const SettingsPageBody(),
    );
  }
}

class SettingsPageBody extends StatefulWidget {
  const SettingsPageBody({Key key}) : super(key: key);

  @override
  _SettingsPageBodyState createState() => _SettingsPageBodyState();
}

class _SettingsPageBodyState extends State<SettingsPageBody> {
  final adService = AdService();
  @override
  void didChangeDependencies() {
    adService.bannerAd.load();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //SIGN IN
            // Padding(
            //   padding: const EdgeInsets.only(top: 15, bottom: 20),
            //   child: settingsSignIn(
            //       radius: radius, context: context, onPress: () {}),
            // ),

            //Theme
            const Padding(
              padding: EdgeInsets.only(bottom: 15, top: 15),
              child: SettingsTheme(),
            ),

            //Language, Notification, Developer, Help and Report etc... pages
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: settingsStructure(
                  title: AppLocalizations.of(context).settingsLanguage,
                  NavigationPage: SettingsLanguageSwitch()),
            ),
            //TODODialog -> Haven't implemented yet
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: settingsStructure(
                title: AppLocalizations.of(context).settingsDeveloper,
                NavigationPage: settingsTemplateScreen(),
              ),
            ),
            //TODODialog -> Maybe in the future
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: settingsStructure(
                title: AppLocalizations.of(context).settingsDonation,
                NavigationPage: settingsTemplateScreen(),
              ),
            ),
            //TODOExpansionPanel
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: settingsStructure(
                title: AppLocalizations.of(context).settingsHelp,
                NavigationPage: settingsTemplateScreen(),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 15),
            //   child: settingsStructure(
            //     title: AppLocalizations.of(context).settingsNotification,
            //     NavigationPage: settingsTemplateScreen(),
            //   ),
            // ),
            //TODODialog -> Maybe in the future
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: settingsStructure(
                title: AppLocalizations.of(context).settingsReport,
                NavigationPage: settingsTemplateScreen(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: settingsStructure(
                title: AppLocalizations.of(context).settingsAbout,
                NavigationPage: const SettingsAboutScreen(),
              ),
            ),

            Container(
              alignment: Alignment.center,
              child: AdWidget(ad: adService.bannerAd),
              width: adService.bannerAd.size.width.toDouble(),
              height: adService.bannerAd.size.height.toDouble(),
            )
          ],
        ),
      ),
    );
  }
}
