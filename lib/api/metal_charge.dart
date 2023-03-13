class MetalCharge {
  String _name = '';
  double _costPerDay = 0.0;
  double _chargePercent = 0.0;
  double _weight = 0.0;
  double _value = 0.0;


  MetalCharge(this._name, this._costPerDay, this._chargePercent, this._weight, this._value);

  String get getName{
    return _name;
  }

  get getCostPerDay{
    return _costPerDay;
  }

  get getChargePercent{
    return _chargePercent;
  }

  get getWeight{
    return _weight;
  }

  get getValue{
    return _value;
  }

}
