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

  String? _selectedCurrency;
  String? _selectedWeight;

  List<String> _currencies = ['USD', 'EUR', 'GBP', 'MYR', 'SGD', 'AUD'];
  List<String> _weights = ['Toz', 'Kilo', 'Grams'];

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedCurrency = prefs.getString('Currency') ?? 'USD';
      _selectedWeight = prefs.getString('Weight') ?? 'Toz';
    });
  }

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
                onChanged: (String? newValue) async {
                  final prefs = await SharedPreferences.getInstance();
                  setState(() {
                    _selectedCurrency = newValue;
                    prefs.setString('Currency', '$newValue');
                    user.setChosenCurrency = _selectedCurrency!;
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
                onChanged: (String? newValue) async {
                  final prefs = await SharedPreferences.getInstance();
                  setState(() {
                    _selectedWeight = newValue;
                    prefs.setString('Weight', '$newValue');
                    user.setChosenCurrency = _selectedCurrency!;
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
      ),
    );
  }
}
