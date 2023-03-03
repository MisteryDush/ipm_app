class Injection {
  DateTime _initialDate = DateTime.now();
  double _currentInvestment = 0.0;
  double _initialInvestment = 0.0;
  double _valueChange = 0.0;
  double _valueChangePercentage = 0.0;
  double _chargePercentage = 0.0;

  DateTime get GetInitialDate {
    return _initialDate;
  }

  double get GetCurrentInvestment {
    return _currentInvestment;
  }

  double get GetInitialInvestment {
    return _initialInvestment;
  }

  double get GetValueChange {
    return _valueChange;
  }

  double get GetValueChangePercentage {
    return _valueChangePercentage;
  }

  double get GetChargePercentage {
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
