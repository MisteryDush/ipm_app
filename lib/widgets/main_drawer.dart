import 'package:flutter/material.dart';

import '../login.dart';

class MainDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColorIndigo,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            leading: Icon(
              Icons.home,
              size: 30,
              color: textColorGold,
            ),
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              if(ModalRoute.of(context)?.settings.name != '/menu') {
                Navigator.popAndPushNamed(context, '/menu');
              }
            },
          ),
          ListTile(
            leading: Icon(
              Icons.area_chart_outlined,
              size: 30,
              color: textColorGold,
            ),
            title: const Text(
              'Historical Vault Valuations',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.attach_money,
              size: 30,
              color: textColorGold,
            ),
            title: const Text(
              'Vault/MGT % Cost Charges',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.price_change_outlined,
              size: 30,
              color: textColorGold,
            ),
            title: const Text(
              'Injections Page',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.file_download,
              size: 30,
              color: textColorGold,
            ),
            title: const Text(
              'Download Reports',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 30,
              color: textColorGold,
            ),
            title: const Text(
              'Settings',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              if(ModalRoute.of(context)?.settings.name != '/settings') {
                Navigator.popAndPushNamed(context, '/settings');
              }
            },
          )
        ],
      ),
    );
  }

}