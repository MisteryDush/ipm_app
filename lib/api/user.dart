import 'package:flutter/material.dart';
import 'package:forex_conversion/forex_conversion.dart';
import 'package:intl/intl.dart';
import 'package:ipm_app/api/commodity.dart';
import 'package:ipm_app/api/injection.dart';
import 'package:ipm_app/api/metal_charge.dart';
import 'package:ipm_app/api/sub_injection.dart';
import 'package:ipm_app/single_injection_page.dart';
import 'package:requests/requests.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'metal_historic_performance.dart';

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
  final _metalCharges = [];

  List<MetalHistoricPerformance> _metals = [];

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

  get getChartData => null;

  MetalHistoricPerformance get getSpotPrices => _metals[0];

  set setChosenWeight(String newWeight) {
    _chosenWeight = newWeight;
  }

  get getChosenWeight {
    return _chosenWeight;
  }

  get allHist {
    return _metals[1];
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

    for (dynamic metalCharge in json['chargeData']['metalCharges']) {
      _metalCharges.add(MetalCharge(
          metalCharge['commodity'],
          double.parse(metalCharge['costPerDay']),
          double.parse(metalCharge['chargePercent']),
          double.parse(metalCharge['weight']),
          double.parse(metalCharge['value'])));
    }

    json['injectionData'].forEach((k, v) => (_injections.add(Injection(
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

    r = await Requests.get(
        'https://portal.demo.ipm.capital/mobileApi/data/getUserInjection',
        headers: {'Authorization': 'Bearer $getToken'},
        bodyEncoding: RequestBodyEncoding.FormURLEncoded,
        timeoutSeconds: 20);

    var injectionJson = r.json();

    for (dynamic currentHolding in injectionJson['currentHoldings']
        ['holdings']) {
      String date = currentHolding['investmentDate'].substring(0, 10);
      var sub = SubInjection(
          currentHolding['commodity'],
          double.parse(currentHolding['currentInvestment']),
          double.parse(currentHolding['initialInvestment']),
          double.parse(currentHolding['weight']),
          double.parse(currentHolding['valueChange']),
          double.parse(currentHolding['valueChangePercentage']));
      Injection inj = _injections
          .firstWhere((element) => date == element.getDate('yyyy-MM-dd'));
      inj.subInjections.add(sub);
    }

    _metals.add(MetalHistoricPerformance(
        'Spot Price',
        injectionJson['historicPerformance']['allData']['allTime']
            ['allMetalsSpotPrice']['data'],
        injectionJson['historicPerformance']['allData']['allTime']
            ['allMetalsSpotPrice']['labels']));

    _metals.add(MetalHistoricPerformance(
        'All Metals',
        injectionJson['historicPerformance']['allData']['allTime']
            ['allMetalsData']['data'],
        injectionJson['historicPerformance']['allData']['allTime']
            ['allMetalsData']['labels']));
    injectionJson['historicPerformance']['allData']['allTime']['metalsData']
        .forEach((k, v) =>
            (_metals.add(MetalHistoricPerformance(k, v['data'], v['labels']))));

    print(_metals);
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

  List<DataRow> getInjectionRows(BuildContext context) {
    var totalFormat = NumberFormat("###,###.0#", "en_US");
    var dateFormat = DateFormat('yyyy-MM-dd');
    List<DataRow> injectionRows = [];
    for (int i = 0; i < _injections.length; i++) {
      Injection injection = _injections[i];
      var tempRow = DataRow(
          onSelectChanged: (selected) {
            {
              if (selected!) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SingleInjectionPage(
                          injection: injection,
                        )));
              }
            }
          },
          cells: [
            DataCell(Text(
              dateFormat.format(injection.getInitialDate),
              style: TextStyle(fontSize: 30),
            )),
            DataCell(Text(
              totalFormat.format(injection.getCurrentInvestment *
                  currencyRates[_chosenCurrency]!),
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
              totalFormat.format(injection.getInitialInvestment *
                  currencyRates[_chosenCurrency]!),
              style: TextStyle(fontSize: 30),
            )),
          ],
          color: MaterialStateColor.resolveWith(
            (states) => (i % 2 == 0) ? Colors.white : Colors.grey.shade200,
          ));
      injectionRows.add(tempRow);
    }
    return injectionRows;
  }

  List<DataRow> getCostChargesRows() {
    double _totalCostPerDay = 0.0;
    double _totalChargePercent = 0.0;
    var totalFormat = NumberFormat("###,##0.0#", "en_US");
    List<DataRow> dataRows = [];
    for (int i = 0; i < _metalCharges.length; i++) {
      MetalCharge metalCharge = _metalCharges[i];
      if (metalCharge.getValue <= 0) continue;
      _totalCostPerDay += metalCharge.getCostPerDay;
      _totalChargePercent += metalCharge.getChargePercent;
      var tempRow = DataRow(
          cells: [
            DataCell(Text(
              metalCharge.getName.toCapitalized(),
              style: TextStyle(fontSize: 30),
            )),
            DataCell(Text(
              totalFormat.format(
                  metalCharge.getCostPerDay * currencyRates[_chosenCurrency]!),
              style: TextStyle(fontSize: 30),
            )),
            DataCell(Text(
              '${totalFormat.format(metalCharge.getChargePercent)}%',
              style: TextStyle(fontSize: 30),
            )),
            DataCell(Text(
              totalFormat
                  .format(metalCharge.getWeight * weightRates[_chosenWeight]!),
              style: TextStyle(fontSize: 30),
            )),
            DataCell(Text(
              totalFormat.format(
                  metalCharge.getValue * currencyRates[_chosenCurrency]!),
              style: TextStyle(fontSize: 30),
            ))
          ],
          color: MaterialStateColor.resolveWith(
            (states) => (i % 2 == 0) ? Colors.white : Colors.grey.shade200,
          ));
      dataRows.add(tempRow);
    }
    dataRows.add(DataRow(cells: [
      DataCell(Text('Total',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
      DataCell(Text(
          totalFormat
              .format(_totalCostPerDay * currencyRates[_chosenCurrency]!),
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
      DataCell(Text('${totalFormat.format(_totalChargePercent)}%',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
      DataCell(Text(
          totalFormat.format(_totalWeight * weightRates[_chosenWeight]!),
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
      DataCell(Text(
          totalFormat.format(_totalValue * currencyRates[_chosenCurrency]!),
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
    ]));
    return dataRows;
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
