// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movieaddict/services/admob_service.dart';
import 'package:movieaddict/services/themeProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsTheme extends StatefulWidget {
  const SettingsTheme({Key key}) : super(key: key);

  @override
  State<SettingsTheme> createState() => _SettingsThemeState();
}

class _SettingsThemeState extends State<SettingsTheme> {
  final adService = AdService();
  int remaingingAdsCount;
  RewardedAd rewardedAd;

  Future waitCallBack() async {
    await adService.setDefaultRemainingAdsCount();
    int count = await adService.getCount();
    setState(() {
      remaingingAdsCount = count;
    });
  }

  void createRewardedAd() {
    RewardedAd.load(
        adUnitId: adService.checkRewardAdsUnitId(),
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            debugPrint('$ad loaded.');
            rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('RewardedAd failed to load: $error');

            rewardedAd = null;
          },
        ));
  }

  void showRewardedAd() {
    if (rewardedAd == null) {
      debugPrint('Warning: attempt to show rewarded before loaded.');
      return;
    }

    rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          debugPrint('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        setState(() {});
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createRewardedAd();
      },
    );

    rewardedAd.setImmersiveMode(true);
    rewardedAd.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) async {
      int count = await adService.getCount();
      remaingingAdsCount = count;
      if (remaingingAdsCount > 0) {
        remaingingAdsCount -= 1;
        debugPrint('After Watch Ad Count $remaingingAdsCount');
        adService.setCount(remaingingAdsCount: remaingingAdsCount);
      }
    });

    rewardedAd = null;
  }

  @override
  void initState() {
    createRewardedAd();
    waitCallBack();
    super.initState();
  }

  @override
  void dispose() {
    rewardedAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Container(
      width: 345,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Theme.of(context).secondaryHeaderColor,
        boxShadow: const [
          BoxShadow(
              color: Color(0xff000000),
              offset: Offset(2, 2),
              blurRadius: 4.0,
              spreadRadius: -2.0),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              AppLocalizations.of(context).settingsTheme,
              style: GoogleFonts.montserrat(
                  color: Theme.of(context).focusColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: (remaingingAdsCount != 0)
                ? TextButton.icon(
                    label: Text(remaingingAdsCount.toString(),
                        style: GoogleFonts.montserrat(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16)),
                    onPressed: () {
                      showRewardedAd();
                    },
                    icon: Icon(
                      Icons.play_arrow_rounded,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ))
                : Switch(
                    activeColor: Colors.black87,
                    inactiveThumbColor: Colors.white10,
                    inactiveTrackColor: Colors.grey[300],
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      final themeProvider =
                          Provider.of<ThemeProvider>(context, listen: false);
                      themeProvider.toggleTheme(value);
                    }),
          )
        ],
      ),
    );
  }
}
// Widget settingsTheme({@required context, @required radius, @required onPress}) {
//   final themeProvider = Provider.of<ThemeProvider>(context);
//   return Container(
//     width: 345,
//     height: 50,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.all(Radius.circular(radius.first)),
//       color: Theme.of(context).secondaryHeaderColor,
//       boxShadow: const [
//         BoxShadow(
//             color: Color(0xff000000),
//             offset: Offset(2, 2),
//             blurRadius: 4.0,
//             spreadRadius: -2.0),
//       ],
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 25),
//           child: Text(
//             AppLocalizations.of(context).settingsTheme,
//             style: GoogleFonts.montserrat(
//                 color: Theme.of(context).focusColor,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w300),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(right: 25),
//           child: Switch(
//               activeColor: Colors.black87,
//               inactiveThumbColor: Colors.white10,
//               inactiveTrackColor: Colors.grey[300],
//               value: themeProvider.isDarkMode,
//               onChanged: (value) {
//                 final themeProvider =
//                     Provider.of<ThemeProvider>(context, listen: false);
//                 themeProvider.toggleTheme(value);
//               }),
//           // child: Text('Developing'),
//         )
//       ],
//     ),
//   );
// }
