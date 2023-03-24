import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ipm_app/widgets/main_app_bar.dart';
import 'package:ipm_app/widgets/main_drawer.dart';

import 'api/user.dart';

const Color textColorGold = Color.fromRGBO(209, 142, 48, 1);
const Color backgroundColorIndigo = Color.fromRGBO(49, 0, 94, 1);

class Menu extends StatelessWidget {
  User user = User.instance;
  var totalFormat = NumberFormat("###,##0.0#", "en_US");
  var percentageFormat = NumberFormat("##0.0#", "en_US");
  var differenceFormat = NumberFormat("###,##0.0#", "en_US");

  double dividerGap = 0.0;

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

    var height = 0.0;

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      height = MediaQuery.of(context).size.width + 130;
      dividerGap = 10;
    } else {
      height = MediaQuery.of(context).size.height - 130;
      dividerGap = 30;
    }

    return Scaffold(
      body: Scaffold(
        appBar: MainAppBar(_scaffoldKey),
        body: Scaffold(
            key: _scaffoldKey,
            drawer: MainDrawer(),
            body: SizedBox(
                height: MediaQuery.of(context).size.height,
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
                              'Welcome\n${user.getName}!',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: textColorGold,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            )),
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
                                )),
                          ],
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                            child: Column(children: [
                              Text(
                                'Value:',
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
                              Text(
                                'Appreciation:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                differenceFormat
                                    .format(user.getValueDifference),
                                style: TextStyle(
                                  fontSize: 20,
                                  color: getColor(user.getValueDifference),
                                ),
                              ),
                              Text(
                                'Percentage:',
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
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: FittedBox(
                                  child: SizedBox(
                                    height: 450,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                )))),
      ),
    );
  }

  Color getColor(double value) {
    return value < 0 ? Colors.red : Colors.green;
  }
}
