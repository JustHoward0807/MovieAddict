import 'package:flutter/material.dart';

class settingsTemplateScreen extends StatelessWidget {
  const settingsTemplateScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                // Navigator.pushReplacement(
                //     context,
                //     PageRouteBuilder(pageBuilder: (_, __, ___) => SettingPage()));
              }),
          title: const Text('Developing Page'),
        ),
        body: const Center(
          child: Text('Developing Page'),
        ));
  }
}
