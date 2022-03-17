import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movieaddict/models/hive_model.dart';
import 'package:movieaddict/models/movie.dart';
import 'package:movieaddict/screens/ListPage/list_screen.dart';
import 'package:movieaddict/screens/WatchLaterPage/watch_later_screen.dart';
import 'package:movieaddict/screens/home_screen.dart';
import 'package:movieaddict/screens/SettingsPage/settings_page.dart';
import 'package:movieaddict/services/languageProvider.dart';
import 'package:movieaddict/services/movie_service.dart';
import 'package:movieaddict/services/themeProvider.dart';
import 'package:movieaddict/widgets/custom_animated_btn_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveModelAdapter());
  Hive.registerAdapter(ActorAdapter());
  await Hive.openBox<HiveModel>('watchlater');
  await MobileAds.instance.initialize();
  runApp(MovieApp());
}

class MovieApp extends StatelessWidget {
  final MovieService movieService = MovieService();

  MovieApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LanguageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        StreamProvider(
          create: (context) => movieService.fetchmovies(),
          initialData: null,
        ),
      ],
      child: Builder(builder: (context) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return
            // StreamProvider(
            //   create: (context) => movieService.fetchmovies(),
            //   catchError: (context, error) {
            //     print('Error!!!!!!: ${error.toString()} ');
            //   },
            //   child:
            MaterialApp(
          locale: Provider.of<LanguageProvider>(context, listen: true).locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale.fromSubtags(
                languageCode: 'zh', scriptCode: 'Hant', countryCode: 'TW'),
          ],
          themeMode: themeProvider.themeMode,
          theme: CustomThemes.lightTheme,
          darkTheme: CustomThemes.darkTheme,
          debugShowCheckedModeBanner: false,
          home: const CustomNavBtnBarWidget(),
          // )
        );
      }),
    );
  }
}

class CustomNavBtnBarWidget extends StatefulWidget {
  const CustomNavBtnBarWidget({Key key}) : super(key: key);

  @override
  _CustomNavBtnBarWidgetState createState() => _CustomNavBtnBarWidgetState();
}

class _CustomNavBtnBarWidgetState extends State<CustomNavBtnBarWidget> {
  int screenIndex = 0;

  Widget getScreens() {
    List<Widget> screens = [
      // HomePage(),
      HomeScreen(),
      ListScreen(),
      // ListPage(),
      WatchLaterScreen(),
      const SettingPage(),
    ];
    return IndexedStack(
      index: screenIndex,
      children: screens,
    );
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBtnBar(
      selectedIndex: screenIndex,
      curve: Curves.easeInOutBack,
      animationDuration: const Duration(milliseconds: 600),
      onItemSelected: (index) => setState(() => screenIndex = index),
      items: <BottomNavBarItem>[
        BottomNavBarItem(
          icon: const Icon(Icons.home_rounded,
              color: Color(0xff252E2C), size: 30),
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text('HOME',
                style: GoogleFonts.orbitron(
                    fontWeight: FontWeight.w600, fontSize: 24)),
          ),
          textAlign: TextAlign.center,
        ),
        BottomNavBarItem(
          icon: const Icon(
            Icons.reorder_rounded,
            color: Color(0xff252E2C),
            size: 30,
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text('LIST',
                style: GoogleFonts.orbitron(
                    fontWeight: FontWeight.w600, fontSize: 24)),
          ),
          textAlign: TextAlign.center,
        ),
        BottomNavBarItem(
          icon: const Icon(Icons.bookmark_rounded,
              color: Color(0xff252E2C), size: 30),
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text('WATCH\n LATER',
                style: GoogleFonts.orbitron(
                    fontWeight: FontWeight.w600, fontSize: 24)),
          ),
          textAlign: TextAlign.center,
        ),
        BottomNavBarItem(
          icon: const Icon(Icons.settings_rounded,
              color: Color(0xff252E2C), size: 30),
          title: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text('MORE',
                style: GoogleFonts.orbitron(fontWeight: FontWeight.w600)),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getScreens(), bottomNavigationBar: _buildBottomBar());
  }
}


// class TabBarPage extends StatefulWidget {
//   @override
//   _TabBarPageState createState() => _TabBarPageState();
// }

// class _TabBarPageState extends State<TabBarPage>
//     with SingleTickerProviderStateMixin {
//   TabController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = TabController(length: 4, vsync: this);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: TabBarView(controller: _controller, children: <Widget>[
//         HomeScreen(),
//         // HomePage(),
//         ListPage(),
//         HomePage(),
//         SettingPage(),
//       ]),
//       bottomNavigationBar: TabBar(
//           controller: _controller,
//           indicator: UnderlineTabIndicator(
//             borderSide: BorderSide(color: Colors.white70, width: 5.0),
//             insets: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 70.0),
//           ),
//           unselectedLabelColor: Colors.white54,
//           labelColor: Colors.amberAccent,
//           labelStyle: mainFontStyle,
//           tabs: <Tab>[
//             Tab(
//               text: AppLocalizations.of(context).navHome,
//               icon: Icon(
//                 Icons.home,
//                 size: 30,
//               ),
//             ),
//             Tab(
//               text: AppLocalizations.of(context).navList,
//               icon: Icon(Icons.format_list_bulleted),
//             ),
//             Tab(
//               text: AppLocalizations.of(context).navLater,
//               icon: Icon(Icons.sentiment_satisfied),
//             ),
//             Tab(
//               text: AppLocalizations.of(context).navSettings,
//               icon: Icon(Icons.settings),
//             ),
//           ]),
//     );
//   }
// }