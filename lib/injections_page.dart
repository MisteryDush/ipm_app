import 'package:flutter/material.dart';
import 'package:ipm_app/widgets/main_app_bar.dart';
import 'package:ipm_app/widgets/main_drawer.dart';

import 'api/user.dart';
import 'login.dart';


class InjectionsPage extends StatefulWidget {
  @override
  _InjectionsPageState createState() => _InjectionsPageState();
}

class _InjectionsPageState extends State<InjectionsPage> {
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
                    'Injections',
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          style: TextStyle(fontSize: 12, color: Colors.black),
                          children: [
                            TextSpan(
                              text: 'Note: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: 'Valuation costs are based purely on '
                            ),
                            TextSpan(
                              text: '${user.getChosenCurrency} paper prices',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text:
                              ' and may not accurately value your physical metals, '
                                  'as premiums on physical products can vary.\n'
                            ),
                            TextSpan(
                              text: 'Note: ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: 'Valuations are presently updated on an hourly basis.',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
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
                                  'Initial Invest\nDate',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: textColorGold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Current\n${user.getChosenCurrency} Value',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: textColorGold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  '${user.getChosenCurrency} Value\nChange',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: textColorGold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Value Change\nPercentage',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: textColorGold,
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Initial ${user.getChosenCurrency}\nPaper Valuation',
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