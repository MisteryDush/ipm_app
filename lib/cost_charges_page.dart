import 'package:flutter/material.dart';
import 'package:ipm_app/widgets/main_app_bar.dart';
import 'package:ipm_app/widgets/main_drawer.dart';

import 'api/user.dart';
import 'login.dart';

class CostChargesPage extends StatefulWidget {
  @override
  _CostChargesPageState createState() => _CostChargesPageState();
}

class _CostChargesPageState extends State<CostChargesPage> {
  User user = User.instance;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  double dividerGap = 0.0;

  List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
  ];

  Widget build(BuildContext context) {
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
                    'Vault/MGT % Cost Charges',
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
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child: Column(children: [
                    Text(
                      'As of ${DateTime.now().day} ${months[DateTime.now().month - 1]} ${DateTime.now().year}',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: FittedBox(
                    child: SizedBox(
                      height: 700,
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
                            headingRowHeight: 100,
                            dataRowHeight: 100,
                            headingRowColor: MaterialStateColor.resolveWith(
                              (states) => backgroundColorIndigo,
                            ),
                            dividerThickness: 2,
                            columns: [
                              DataColumn(
                                label: Text(
                                  'Commodity',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: textColorGold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Cost Per Day',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: textColorGold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Vault % Cost',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: textColorGold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Weight (${user.getChosenWeight})',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: textColorGold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Value (${user.getChosenCurrency})',
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: textColorGold,
                                  ),
                                ),
                              ),
                            ],
                            rows: user.getCostChargesRows(),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ))),
      ),
    );
  }
}
