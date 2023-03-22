class MetalHistoricPerformance{
  var _labels = [];
  String _name = '';
  var _data = [];
  List<ChartData> _chartData = [];

  MetalHistoricPerformance(this._name, this._data, this._labels){
    for (int i = 0; i < _data.length; i++){
      _chartData.add(ChartData(_labels[i], double.parse(_data[i])));
    }
  }

  get getLabels{
    return _labels;
  }

  String get getName => _name;

  get getData{
    return _data;
  }

  get getChartData => _chartData;



}

class ChartData {
  ChartData(this.label, this.data);

  final String label;
  final double data;
}