import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class settingsStructure extends StatefulWidget {
  final String title;
  final Widget NavigationPage;
  const settingsStructure({@required this.title, @required this.NavigationPage});

  @override
  _settingsStructureState createState() => _settingsStructureState();
}

class _settingsStructureState extends State<settingsStructure> {
  bool enabled = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => widget.NavigationPage))
            .then((value) => setState(() {
                  enabled = false;
                }));
      },
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                widget.title,
                style: GoogleFonts.montserrat(
                    fontSize: 18,
                    color: Theme.of(context).focusColor,
                    fontWeight: FontWeight.w300),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 25),
              child: Icon(
                Icons.keyboard_arrow_right,
                size: 40,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
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
