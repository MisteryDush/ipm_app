import 'package:flutter/material.dart';
import 'package:forex_conversion/forex_conversion.dart';
import 'package:intl/intl.dart';
import 'package:ipm_app/api/commodity.dart';
import 'package:ipm_app/api/injection.dart';
import 'package:requests/requests.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  String _token = '';
  String _name = '';
  double _totalWeight = 0.0;
  double _totalValue = 0.0;
  double _lastTotalValue = 0.0;
  double _valueDifference = 0.0;
  double _valueDifferencePercentage = 0.0;
  final _commodities = [];
  final _injections = [];
  final Map<String, double> weightRates = {
    'Toz': 1.0,
    'Kilo': 0.0311034768,
    'Grams': 31.1034768
  };

  Map<String, double> currencyRates = {
    'USD': 1.0,
    'EUR': 0.0,
    'GBP': 0.0,
    'MYR': 0.0,
    'SGD': 0.0,
    'AUD': 0.0
  };
  String _chosenCurrency = 'USD';
  String _chosenWeight = 'Toz';
  final fx = Forex();

  String get getChosenCurrency {
    return _chosenCurrency;
  }

  set setChosenWeight(String newWeight) {
    _chosenWeight = newWeight;
  }

  get getChosenWeight {
    return _chosenWeight;
  }

  set setChosenCurrency(String newCurrency) {
    _chosenCurrency = newCurrency;
  }

  double get getLastTotalValue {
    return _lastTotalValue;
  }

  double get getValueDifference {
    return _valueDifference * currencyRates[_chosenCurrency]!;
  }

  double get getValueDifferencePercentage {
    return _valueDifferencePercentage;
  }

  double get getTotalValue {
    return _totalValue * currencyRates[_chosenCurrency]!;
  }

  double get getTotalWeight {
    return _totalWeight;
  }

  void get getCommodities {
    for (Commodity i in _commodities) {
      if (i.getValue > 0) {
        print(i.toString());
      }
    }
  }

  String get getName {
    return _name;
  }

  List get getInjections {
    return _injections;
  }

  set _setName(String newName) {
    if (_name.isEmpty) {
      _name = newName;
    }
  }

  String get getToken {
    return _token;
  }

  set _setToken(String newToken) {
    if (_token.isEmpty) {
      _token = newToken;
    }
  }

  User._();

  static final instance = User._();

  static Future<void> createUser(String username, String password) async {
    await instance.setup(username, password);
    await instance.getRates();
  }

  Future<List> login(String username, String password) async {
    var r =
    await Requests.post('http://portal.demo.ipm.capital/mobileApi/login',
        body: {
          'username': username,
          'password': password,
        },
        bodyEncoding: RequestBodyEncoding.FormURLEncoded,
        timeoutSeconds: 20);
    return [r.statusCode, r.json()];
  }

  Future<void> setup(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _chosenCurrency = prefs.getString('Currency') ?? 'USD';
    _chosenWeight = prefs.getString('Weight') ?? 'Toz';
    var r = await login(username, password);
    if (r[0] == 200) {
      _setToken = r[1]['token'];
    } else {
      throw LoginException();
    }
    await initializeData();
  }

  Future<void> initializeData() async {
    var r = await Requests.get(
        'https://portal.demo.ipm.capital/mobileApi/data/getUserData',
        headers: {'Authorization': 'Bearer $getToken'},
        bodyEncoding: RequestBodyEncoding.FormURLEncoded,
        timeoutSeconds: 20);
    dynamic json = r.json();
    _setName = json['alias'];
    _totalWeight = double.parse(json['holdingData']['totalWeight']);
    _totalValue = double.parse(json['holdingData']['totalValue']);
    for (dynamic commodity in json['holdingData']['holdings']) {
      _commodities.add(Commodity(
          commodity['commodity'],
          double.parse(commodity['commodityValue']),
          double.parse(commodity['value']),
          double.parse(commodity['valuePercentage']),
          double.parse(commodity['weight']),
          double.parse(commodity['totalCharges']),
          double.parse(commodity['totalChargesPercentage'])));
    }
    json['injectionData'].forEach((k, v) =>
    (_injections.add(Injection(
        DateTime.parse(v['initialDate']),
        double.parse(v['currentInvestment']),
        double.parse(v['initialInvestment']),
        double.parse(v['valueChange']),
        v['valueChangePercentage'].toDouble(),
        double.parse(v['chargePercentage'])))));
    _lastTotalValue = double.parse(json['historicPerformance']['allTimeData']
    ['allMetalsData']['data'][json['historicPerformance']['allTimeData']
    ['allMetalsData']['data']
        .length -
        1]);
    _valueDifference = _totalValue - _lastTotalValue;
    _valueDifferencePercentage = (_valueDifference) / _lastTotalValue * 100;
  }

  List<DataRow> getCommoditiesRows() {
    var totalFormat = NumberFormat("###,###.0#", "en_US");
    List<DataRow> dataRows = [];
    for (int i = 0; i < _commodities.length; i++) {
      Commodity commodity = _commodities[i];
      if (commodity.getValue <= 0) continue;
      var tempRow = DataRow(
          cells: [
            DataCell(Text(
              commodity.getName.toCapitalized(),
              style: TextStyle(fontSize: 24),
            )),
            DataCell(Text(
              totalFormat
                  .format(commodity.getValue * currencyRates[_chosenCurrency]!),
              style: TextStyle(fontSize: 24),
            )),
            DataCell(Text(
              totalFormat
                  .format(commodity.getWeight * weightRates[_chosenWeight]!),
              style: TextStyle(fontSize: 24),
            )),
            DataCell(Text(
              totalFormat.format(
                  commodity.getLatestPrice * currencyRates[_chosenCurrency]!),
              style: TextStyle(fontSize: 24),
            ))
          ],
          color: MaterialStateColor.resolveWith(
                (states) => (i % 2 == 0) ? Colors.white : Colors.grey.shade200,
          ));
      dataRows.add(tempRow);
    }
    dataRows.add(DataRow(cells: [
      DataCell(Text('Total',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
      DataCell(Text(
          totalFormat.format(_totalValue * currencyRates[_chosenCurrency]!),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
      DataCell(Text(
          totalFormat.format(_totalWeight * weightRates[_chosenWeight]!),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
      DataCell(Text(''))
    ]));
    return dataRows;
  }

  List<DataRow> getInjectionRows() {
    var totalFormat = NumberFormat("###,###.0#", "en_US");
    List<DataRow> injectionRows = [];
    for (int i = 0; i < _injections.length; i++) {
      Injection injection = _injections[i];
      var tempRow = DataRow(
          onSelectChanged: (selected) {
        {
          if(selected!){
            print('Selected injection: ${injection.getInitialDate}');
          }
        }
      },
          cells: [
        DataCell(
            Text(
          '${injection.getInitialDate.year}-${injection.getInitialDate
              .month}-${injection.getInitialDate.day}',
          style: TextStyle(fontSize: 30),
        )),
        DataCell(Text(
          totalFormat.format(
              injection.getCurrentInvestment * currencyRates[_chosenCurrency]!),
          style: TextStyle(fontSize: 30),
        )),
        DataCell(Text(
          totalFormat.format(
              injection.getValueChange * currencyRates[_chosenCurrency]!),
          style: TextStyle(fontSize: 30),
        )),
        DataCell(Text(
          '${totalFormat.format(injection.getValueChangePercentage)}%',
          style: TextStyle(fontSize: 30),
        )),
        DataCell(Text(
          totalFormat.format(
              injection.getInitialInvestment * currencyRates[_chosenCurrency]!),
          style: TextStyle(fontSize: 30),
        )),
      ], color: MaterialStateColor.resolveWith(
            (states) =>
        (i % 2 == 0) ? Colors.white : Colors.grey.shade200
        ,));
          injectionRows.add(tempRow);
    }
    return
      injectionRows;
  }

  Future<void> getRates() async {
    currencyRates['EUR'] = await fx.getCurrencyConverted('USD', 'EUR', 1);
    currencyRates['GBP'] = await fx.getCurrencyConverted('USD', 'GBP', 1);
    currencyRates['MYR'] = await fx.getCurrencyConverted('USD', 'MYR', 1);
    currencyRates['SGD'] = await fx.getCurrencyConverted('USD', 'SGD', 1);
    currencyRates['AUD'] = await fx.getCurrencyConverted('USD', 'AUD', 1);
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
}

class LoginException implements Exception {
  LoginException();
}
