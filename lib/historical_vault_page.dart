import 'package:flutter/material.dart';
import 'package:ipm_app/login.dart';
import 'package:ipm_app/widgets/main_app_bar.dart';
import 'package:ipm_app/widgets/main_drawer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HistoricalVaultPage extends StatefulWidget {
  @override
  _HistoricalVaultPageState createState() => _HistoricalVaultPageState();
}

class _HistoricalVaultPageState extends State<HistoricalVaultPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  Widget build(BuildContext context) {
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
                    SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <ChartSeries>[
                        LineSeries<ChartData, String>(
                            dataSource: [
                              ChartData('Jan', 35),
                              ChartData('Feb', 23),
                              ChartData('Jun', 25),
                              ChartData('Mar', 35),
                              ChartData('Apr', 23),
                              ChartData('May', 25),
                              ChartData('Sep', 35),
                              ChartData('Oct', 23),
                              ChartData('Nov', 25),
                              ChartData('Dec', 35),
                              ChartData('Jul', 23),
                              ChartData('Aug', 25),
                              ChartData('Jan1', 35),
                              ChartData('Feb1', 23),
                              ChartData('Jun1', 25),
                              ChartData('Mar1', 35),
                              ChartData('Apr1', 23),
                              ChartData('May1', 25),
                              ChartData('Sep1', 35),
                              ChartData('Oct1', 23),
                              ChartData('Nov1', 25),
                              ChartData('Dec1', 35),
                              ChartData('Jul1', 23),
                              ChartData('Aug1', 25),
                              ChartData('Jan2', 35),
                              ChartData('Feb2', 23),
                              ChartData('Jun2', 25),
                              ChartData('Mar2', 35),
                              ChartData('Apr2', 23),
                              ChartData('May2', 25),
                              ChartData('Sep2', 35),
                              ChartData('Oct2', 23),
                              ChartData('Nov2', 25),
                              ChartData('Dec2', 35),
                              ChartData('Jul2', 23),
                              ChartData('Aug2', 25),
                            ],
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y)
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

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double? y;
}
