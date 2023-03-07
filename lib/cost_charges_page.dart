import 'package:flutter/material.dart';
import 'package:ipm_app/widgets/main_app_bar.dart';
import 'package:ipm_app/widgets/main_drawer.dart';


class CostChargesPage extends StatefulWidget {
  @override
  _CostChargesPageState createState() => _CostChargesPageState();
}

class _CostChargesPageState extends State<CostChargesPage> {

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