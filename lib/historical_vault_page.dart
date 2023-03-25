import 'package:flutter/material.dart';
import 'package:ipm_app/login.dart';
import 'package:ipm_app/widgets/main_app_bar.dart';
import 'package:ipm_app/widgets/main_drawer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'api/metal_historic_performance.dart';
import 'api/user.dart';

class HistoricalVaultPage extends StatefulWidget {
  @override
  _HistoricalVaultPageState createState() => _HistoricalVaultPageState();
}

class _HistoricalVaultPageState extends State<HistoricalVaultPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  User user = User.instance;

  double dividerGap = 0.0;
  late TooltipBehavior _tooltipBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

  MetalHistoricPerformance? dropdownValue;
  String? dropdownTime;
  int? firstIndex;

  Widget build(BuildContext context) {
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      maximumZoomLevel: 0.1,
      zoomMode: ZoomMode.x,
      enablePanning: true,
    );
    dropdownTime ??= 'Since Inception';
    dropdownValue ??= user.allHist;
    firstIndex ??= 0;
    MetalHistoricPerformance spotPrices = user.getSpotPrices;

    final List<Color> colors = [
      Color.fromRGBO(119, 119, 246, 0.6)
    ];
    final List<double> stops = [0.0];

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      dividerGap = 10;
    } else {
      dividerGap = 30;
    }

    return Scaffold(
      appBar: MainAppBar(_scaffoldKey),
      body: Scaffold(
        key: _scaffoldKey,
        drawer: MainDrawer(),
        body: SizedBox(
            child: SingleChildScrollView(
                child: Padding(
          padding: EdgeInsets.zero,
          child: SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Text(
                    'Historical Vault Valuations',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: textColorGold,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: dividerGap),
                      child: Image.asset(
                        'assets/images/logo_divide.png',
                        width: 320,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Text(
                    'Charts Values are being displayed in ${user.getChosenCurrency}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: DropdownButton<MetalHistoricPerformance>(
                                  value: dropdownValue,
                                  items: user.getDropdownAllMetals,
                                  onChanged:
                                      (MetalHistoricPerformance? newValue) {
                                    setState(() {
                                      dropdownValue = newValue!;
                                      if (dropdownTime == 'Last 12 Months') {
                                        firstIndex =
                                            dropdownValue!.getChartData.length -
                                                365;
                                      }
                                    });
                                  },
                                  underline: SizedBox(),
                                ))),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: DropdownButton<String>(
                                  value: dropdownTime,
                                  items: <String>[
                                    'Since Inception',
                                    'Last 12 Months'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      child: Text(value),
                                      value: value,
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownTime = newValue!;
                                      if (dropdownTime == 'Since Inception') {
                                        firstIndex = 0;
                                      } else {
                                        firstIndex =
                                            dropdownValue!.getChartData.length -
                                                365;
                                      }
                                      print(dropdownValue);
                                    });
                                  },
                                  underline: SizedBox(),
                                )))
                      ]),
                ),
                SfCartesianChart(
                  zoomPanBehavior: _zoomPanBehavior,
                  tooltipBehavior: _tooltipBehavior,
                  primaryXAxis: CategoryAxis(),
                  axes: [CategoryAxis(name: 'yAxis', opposedPosition: true)],
                  legend: Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                      overflowMode: LegendItemOverflowMode.wrap),
                  series: <ChartSeries>[
                    AreaSeries<ChartData, String>(
                        gradient: LinearGradient(colors: colors, stops: stops),
                        opacity: 1,
                        name:
                            '${dropdownValue!.getName.toCapitalized()} Vault Stock Valuation',
                        dataSource:
                            dropdownValue!.getChartData.sublist(firstIndex!),
                        xValueMapper: (ChartData data, _) => data.label,
                        yValueMapper: (ChartData data, _) => (data.data *
                            user.currencyRates[user.getChosenCurrency]!)),
                    // LineSeries<ChartData, String>(
                    //     name:
                    //     '${spotPrices.getName
                    //         .toCapitalized()} Vault Stock Valuation (Right-Hand axis)',
                    //     dashArray: <double>[10, 10],
                    //     dataSource: spotPrices.getChartData,
                    //     xValueMapper: (ChartData data, _) => data.label,
                    //     yValueMapper: (ChartData data, _) =>
                    //     data.data *
                    //         user.currencyRates[user.getChosenCurrency]!,
                    //     yAxisName: 'yAxis')
                  ],
                )
              ],
            ),
          ),
        ))),
      ),
    );
  }
}
