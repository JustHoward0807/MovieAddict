import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieaddict/screens/ListPage/search_screen.dart';
import 'package:movieaddict/widgets/ListPage/list_screen_body_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15)),
          ),
          title: Text(AppLocalizations.of(context).listAppBar,
              style: GoogleFonts.montserrat(
                  color: Theme.of(context).focusColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w500)),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchList());
                },
                icon: Icon(
                  Icons.search_rounded,
                  size: 30,
                  color: Theme.of(context).focusColor,
                )),
            //TODOImplement filter function
            // IconButton(
            //   onPressed: null,
            //   icon: Icon(Icons.filter_list_rounded,
            //       size: 30, color: Theme.of(context).errorColor),
            // )
          ],
        ),
        preferredSize: Size(size.width, size.height / 11),
      ),
      body: const ListScreenBodyWidget(),
    );
  }
}
