import 'package:flutter/material.dart';
import 'package:ipm_app/widgets/main_app_bar.dart';
import 'package:ipm_app/widgets/main_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/user.dart';


class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}


class _SettingsPageState extends State<SettingsPage> {

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  String? _selectedCurrency = 'USD';
  String? _selectedWeight = 'Toz';

  List<String> _currencies = ['USD', 'EUR', 'GBP', 'MYR', 'SGD', 'AUD'];
  List<String> _weights = ['Toz', 'Kilo', 'Grams'];


  @override
  Widget build(BuildContext context) {
    User user = User.instance;

    return Scaffold(
        appBar: MainAppBar(_scaffoldKey),
        body: Scaffold(
          key: _scaffoldKey,
          drawer: MainDrawer(),
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Currency',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: _selectedCurrency,
                  onChanged: (String? newValue) {
                    setState(() async {
                      _selectedCurrency = newValue;
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString('Currency', '$newValue');
                      user.setChosenCurrency = newValue!;
                    });
                  },
                  items:
                      _currencies.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Weight',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: _selectedWeight,
                  onChanged: (String? newValue) {
                    setState(() async {
                      final prefs = await SharedPreferences.getInstance();
                      _selectedWeight = newValue;
                      prefs.setString('Weight', '$newValue');
                    });
                  },
                  items: _weights.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ));
  }
}
