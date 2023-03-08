import 'package:flutter/material.dart';

import '../login.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget{

  final GlobalKey<ScaffoldState> _scaffoldKey;

  MainAppBar(this._scaffoldKey);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: backgroundColorIndigo,
        automaticallyImplyLeading: true,
        leading: IconButton(
            icon: Icon(Icons.dehaze),
            onPressed: () {
              if (_scaffoldKey.currentState?.isDrawerOpen == false) {
                _scaffoldKey.currentState?.openDrawer();
              } else {
                _scaffoldKey.currentState?.openEndDrawer();
              }
            }),
        toolbarHeight: 80,
        title: Row(children: [
          Image.asset(
            'assets/images/logo_and_name.png',
            height: 60,
          ),
        ]));
  }

  @override
  Size get preferredSize => Size.fromHeight(80);

}