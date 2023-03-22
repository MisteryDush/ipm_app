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

  Widget build(BuildContext context) {
    MetalHistoricPerformance metal = user.allHist;
    MetalHistoricPerformance spotPrices = user.getSpotPrices;
    var height = 0.0;

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      height = MediaQuery.of(context).size.width + 130;
    } else {
      height = MediaQuery.of(context).size.height - 130;
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
            height: height,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 30),
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
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  axes: [CategoryAxis(name: 'yAxis', opposedPosition: true)],
                  legend: Legend(
                      isVisible: true,
                      position: LegendPosition.bottom,
                      overflowMode: LegendItemOverflowMode.wrap),
                  series: <ChartSeries>[
                    LineSeries<ChartData, String>(
                        name:
                            '${metal.getName.toCapitalized()} Vault Stock Valuation',
                        dataSource: metal.getChartData,
                        xValueMapper: (ChartData data, _) => data.label,
                        yValueMapper: (ChartData data, _) => (data.data *
                            user.currencyRates[user.getChosenCurrency]!)),
                    LineSeries<ChartData, String>(
                        name:
                            '${spotPrices.getName.toCapitalized()} Vault Stock Valuation (Right-Hand axis)',
                        dashArray: <double>[10,10],
                        dataSource: spotPrices.getChartData,
                        xValueMapper: (ChartData data, _) => data.label,
                        yValueMapper: (ChartData data, _) =>
                            data.data *
                            user.currencyRates[user.getChosenCurrency]!,
                        yAxisName: 'yAxis')
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
