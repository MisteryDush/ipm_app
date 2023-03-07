import 'package:flutter/material.dart';
import 'package:ipm_app/widgets/main_app_bar.dart';
import 'package:ipm_app/widgets/main_drawer.dart';


class InjectionsPage extends StatefulWidget {
  @override
  _InjectionsPageState createState() => _InjectionsPageState();
}

class _InjectionsPageState extends State<InjectionsPage> {

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(_scaffoldKey),
      body: Scaffold(
        key: _scaffoldKey,
        drawer: MainDrawer(),
      ),
    );
  }
}