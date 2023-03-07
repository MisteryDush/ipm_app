import 'package:flutter/material.dart';
import 'package:ipm_app/widgets/main_app_bar.dart';
import 'package:ipm_app/widgets/main_drawer.dart';


class HistoricalVaultPage extends StatefulWidget {
  @override
  _HistoricalVaultPageState createState() => _HistoricalVaultPageState();
}

class _HistoricalVaultPageState extends State<HistoricalVaultPage> {

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