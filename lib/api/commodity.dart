class Commodity {
  String _name = '';
  double _latestPrice = 0.0;
  double _value = 0.0;
  double _valuePercentage = 0.0;
  double _weight = 0.0;
  double _totalChargesPercentage = 0.0;
  double _totalCharges = 0.0;

  String get getName {
    return _name;
  }

  double get getLatestPrice {
    return _latestPrice;
  }

  double get getValue {
    return _value;
  }

  double get getValuePercentage {
    return _valuePercentage;
  }

  double get getWeight {
    return _weight;
  }

  double get getTotalCharges {
    return _totalCharges;
  }

  double get getTotalChargesPercentage {
    return _totalChargesPercentage;
  }

  Commodity(
      String name,
      double latestPrice,
      double value,
      double valuePercentage,
      double weight,
      double totalCharges,
      double totalChargesPercentage) {
    _name = name;
    _latestPrice = latestPrice;
    _value = value;
    _valuePercentage = valuePercentage;
    _weight = weight;
    _totalCharges = totalCharges;
    _totalChargesPercentage = totalChargesPercentage;
  }

  @override
  String toString() {
    return '$_name:\n\t\$$getValue\n\t$getWeight\n\t$getValuePercentage\n\t\$$getLatestPrice';
  }
}
