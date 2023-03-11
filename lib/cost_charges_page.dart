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

  Widget build(BuildContext context) {
    return Scaffold(
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
                Padding(padding: EdgeInsets.symmetric(vertical: 25),
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
                    Padding(padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                      child: Image.asset('assets/images/logo_divide.png',
                        width: 320,
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.zero,
                  child: Column(children: [
                    Text('As of (Todays date)',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Time stamp of last data capture: GMT (time)',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ]
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
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
                                  'Cost Per Day',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: textColorGold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Vault % Cost',
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
                                  'Value (${user.getChosenCurrency})',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: textColorGold,
                                  ),
                                ),
                              ),
                            ],
                            rows: [],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}