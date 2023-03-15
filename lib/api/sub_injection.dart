class SubInjection {
  String _name = '';
  double _currentValue = 0.0;
  double _initialValue = 0.0;
  double _weight = 0.0;
  double _valueChange = 0.0;
  double _valueChangePercentage = 0.0;

  String get getName {
    return _name;
  }

  double get getCurrentValue {
    return _currentValue;
  }

  get getInitialValue {
    return _initialValue;
  }

  get getWeight {
    return _weight;
  }

  get getValueChange {
    return _valueChange;
  }

  get getValueChangePercentage {
    return _valueChangePercentage;
  }

  SubInjection(this._name, this._currentValue, this._initialValue, this._weight,
      this._valueChange, this._valueChangePercentage);
}
