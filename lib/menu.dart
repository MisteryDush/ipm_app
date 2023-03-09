import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ipm_app/widgets/main_app_bar.dart';
import 'package:ipm_app/widgets/main_drawer.dart';

import 'api/user.dart';

const Color textColorGold = Color.fromRGBO(209, 142, 48, 1);
const Color backgroundColorIndigo = Color.fromRGBO(49, 0, 94, 1);

class Menu extends StatelessWidget {
  User user = User.instance;
  var totalFormat = NumberFormat("###,###.0#", "en_US");
  var percentageFormat = NumberFormat("###.0#", "en_US");
  var differenceFormat = NumberFormat("###,###.0#", "en_US");

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

    return Scaffold(
      body: Scaffold(
        appBar: MainAppBar(_scaffoldKey),
        body: Scaffold(
            key: _scaffoldKey,
            drawer: MainDrawer(),
            body: Padding(
              padding: EdgeInsets.zero,
              child: SizedBox(
                height: 1000,
                child: Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          'Welcome\n${user.getName}!',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: textColorGold,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        )),
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
                            )),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.zero,
                        child: Column(children: [
                          Text('Value:',
                          style: TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            '${totalFormat.format(user.getTotalValue)} ${user.getChosenCurrency}',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          Text('Appreciation:',
                            style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            differenceFormat.format(user.getValueDifference),
                            style: TextStyle(
                              fontSize: 20,
                              color: getColor(user.getValueDifference),
                            ),
                          ),
                          Text('Percentage:',
                            style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            "${percentageFormat.format(user.getValueDifferencePercentage)}%",
                            style: TextStyle(
                                fontSize: 20,
                                color: getColor(
                                    user.getValueDifferencePercentage)),
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: FittedBox(
                              child: SizedBox(
                                height: 450,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ),
                                    child: DataTable(
                                      headingRowColor:
                                          MaterialStateColor.resolveWith(
                                        (states) => backgroundColorIndigo,
                                      ),
                                      dividerThickness: 2,
                                      columns: [
                                        DataColumn(
                                          label: Text(
                                            'Commodity',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: textColorGold,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Value (${user.getChosenCurrency})',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: textColorGold,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Weight (${user.getChosenWeight})',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: textColorGold,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Latest\nMetal Price',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: textColorGold,
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: user.getCommoditiesRows(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ])),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Color getColor(double value) {
    return value < 0 ? Colors.red : Colors.green;
  }
}
