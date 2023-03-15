import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ipm_app/api/sub_injection.dart';
import 'package:ipm_app/api/user.dart';

class Injection {
  DateTime _initialDate = DateTime.now();
  double _currentInvestment = 0.0;
  double _initialInvestment = 0.0;
  double _valueChange = 0.0;
  double _valueChangePercentage = 0.0;
  double _chargePercentage = 0.0;
  List<SubInjection> subInjections = [];

  DateTime get getInitialDate {
    return _initialDate;
  }

  double get getCurrentInvestment {
    return _currentInvestment;
  }

  double get getInitialInvestment {
    return _initialInvestment;
  }

  double get getValueChange {
    return _valueChange;
  }

  double get getValueChangePercentage {
    return _valueChangePercentage;
  }

  double get getChargePercentage {
    return _chargePercentage;
  }

  String getDate(String formatString) {
    final DateFormat format = DateFormat(formatString);
    return format.format(_initialDate);
  }

  Injection(
      DateTime initialDate,
      double currentInvestment,
      double initialInvestment,
      double valueChange,
      double valueChangePercentage,
      double chargePercentage) {
    _initialDate = initialDate;
    _currentInvestment = currentInvestment;
    _initialInvestment = initialInvestment;
    _valueChangePercentage = valueChangePercentage;
    _valueChange = valueChange;
    _chargePercentage = chargePercentage;
  }

  List<DataRow> getSubInjectionRows() {
    User user = User.instance;

    double totalCurrentValue = 0.0;
    double totalWeight = 0.0;
    double totalValueChange = 0.0;
    double totalPercentage = 0.0;
    double totalInitialValue = 0.0;

    var totalFormat = NumberFormat("###,###.0#", "en_US");
    List<DataRow> dataRows = [];
    for (int i = 0; i < subInjections.length; i++) {
      SubInjection subInjection = subInjections[i];
      totalCurrentValue += subInjection.getCurrentValue;
      totalWeight += subInjection.getWeight;
      totalValueChange += subInjection.getValueChange;
      totalPercentage += subInjection.getValueChangePercentage;
      totalInitialValue += subInjection.getInitialValue;
      var tempRow = DataRow(
          cells: [
            DataCell(Text(
              subInjection.getName.toCapitalized(),
              style: TextStyle(fontSize: 50),
            )),
            DataCell(Text(
              totalFormat.format(subInjection.getCurrentValue *
                  user.currencyRates[user.getChosenCurrency]!),
              style: TextStyle(fontSize: 50),
            )),
            DataCell(Text(
              totalFormat.format(subInjection.getWeight *
                  user.weightRates[user.getChosenWeight]!),
              style: TextStyle(fontSize: 50),
            )),
            DataCell(Text(
              totalFormat.format(subInjection.getValueChange *
                  user.currencyRates[user.getChosenCurrency]!),
              style: TextStyle(fontSize: 50),
            )),
            DataCell(Text(
              totalFormat.format(subInjection.getValueChangePercentage),
              style: TextStyle(fontSize: 50),
            )),
            DataCell(Text(
              totalFormat.format(subInjection.getInitialValue *
                  user.currencyRates[user.getChosenCurrency]!),
              style: TextStyle(fontSize: 50),
            )),
          ],
          color: MaterialStateColor.resolveWith(
            (states) => (i % 2 == 0) ? Colors.white : Colors.grey.shade200,
          ));
      dataRows.add(tempRow);
    }
    var tempRow = DataRow(
      cells: [
        DataCell(Text(
          'Totals',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        )),
        DataCell(Text(
          totalFormat.format(totalCurrentValue *
              user.currencyRates[user.getChosenCurrency]!),
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        )),
        DataCell(Text(
          totalFormat.format(
              totalWeight * user.weightRates[user.getChosenWeight]!),
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        )),
        DataCell(Text(
          totalFormat.format(totalValueChange *
              user.currencyRates[user.getChosenCurrency]!),
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        )),
        DataCell(Text(
          totalFormat.format(totalPercentage),
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        )),
        DataCell(Text(
          totalFormat.format(totalInitialValue *
              user.currencyRates[user.getChosenCurrency]!),
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        )),
      ],
    );

    dataRows.add(tempRow);

    return dataRows;
  }
}
