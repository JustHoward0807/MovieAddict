import 'package:flutter/material.dart';


class SettingsAboutScreen extends StatefulWidget {
  const SettingsAboutScreen({Key key}) : super(key: key);

  @override
  State<SettingsAboutScreen> createState() => _SettingsAboutScreenState();
}

class _SettingsAboutScreenState extends State<SettingsAboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Model Viewer")), body: Text('data'));
  }
}
