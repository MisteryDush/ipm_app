class Injection {
  DateTime _initialDate = DateTime.now();
  double _currentInvestment = 0.0;
  double _initialInvestment = 0.0;
  double _valueChange = 0.0;
  double _valueChangePercentage = 0.0;
  double _chargePercentage = 0.0;

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
}
