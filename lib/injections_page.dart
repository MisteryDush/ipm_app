import 'package:flutter/material.dart';
import 'package:ipm_app/widgets/main_app_bar.dart';
import 'package:ipm_app/widgets/main_drawer.dart';

import 'login.dart';


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
        body: Padding(
          padding: EdgeInsets.zero,
          child: SizedBox(
            height: 1000,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Injections',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: textColorGold,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                      child: Image.asset('assets/images/logo_divide.png',
                        width: 320,
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}