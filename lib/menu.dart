import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: backgroundColorIndigo,
            automaticallyImplyLeading: true,
            leading: IconButton(
                icon: Icon(Icons.dehaze),
                onPressed: () {
                  print(_scaffoldKey.currentState!.isDrawerOpen);
                  if (_scaffoldKey.currentState?.isDrawerOpen == false) {
                    _scaffoldKey.currentState?.openDrawer();
                  } else {
                    _scaffoldKey.currentState?.openEndDrawer();
                  }
                }),
            toolbarHeight: 70,
            title: Row(children: [
              Image.asset(
                'assets/images/logo_and_name.png',
                height: 50,
              ),
            ])),
        body: Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
              backgroundColor: backgroundColorIndigo,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.home,
                      size: 30,
                      color: textColorGold,
                    ),
                    title: const Text(
                      'Home',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.area_chart_outlined,
                      size: 30,
                      color: textColorGold,
                    ),
                    title: const Text(
                      'Historical Vault Valuations',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.attach_money,
                      size: 30,
                      color: textColorGold,
                    ),
                    title: const Text(
                      'Vault/MGT % Cost Charges',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.price_change_outlined,
                      size: 30,
                      color: textColorGold,
                    ),
                    title: const Text(
                      'Injections Page',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.file_download,
                      size: 30,
                      color: textColorGold,
                    ),
                    title: const Text(
                      'Download Reports',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
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
                          Text(
                            totalFormat.format(user.getTotalValue),
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            differenceFormat.format(user.getValueDifference),
                            style: TextStyle(
                              fontSize: 20,
                              color: getColor(user.getValueDifference),
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
                                      headingRowColor: MaterialStateColor.resolveWith(
                                            (states) => backgroundColorIndigo,
                                      ),
                                      dataRowColor: MaterialStateColor.resolveWith(
                                            (states) => Colors.grey.shade200,
                                      ),
                                      dividerThickness: 2,
                                      columns: [
                                        DataColumn(
                                          label: Text(
                                            'Commodity',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: textColorGold,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Value',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: textColorGold,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Weight',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: textColorGold,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Latest\nMetal Price',
                                            style: TextStyle(
                                              fontSize: 20,
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
