import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'api/user.dart';

const Color textColorGold = Color.fromRGBO(209, 142, 48, 1);
const Color backgroundColorIndigo = Color.fromRGBO(49, 0, 94, 1);

class Menu extends StatelessWidget {
  User user = User.instance;
  var totalFormat = NumberFormat("###,###.0#", "en_US");
  var percentageFormat = NumberFormat("###,###.0#", "en_US");
  var differenceFormat = NumberFormat("###,###.0####", "en_US");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColorIndigo,
          toolbarHeight: 70,
          title: Image.asset(
            'assets/images/logo_and_name.png',
            height: 50,
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
                        percentageFormat.format(user.getValueDifference),
                        style: TextStyle(
                          fontSize: 20,
                          color: getColor(user.getValueDifference),
                        ),
                      ),
                      Text(
                        user.getValueDifferencePercentage.toStringAsFixed(2) + '%',
                        style: TextStyle(
                          fontSize: 20,
                          color: getColor(user.getValueDifferencePercentage)
                        ),
                      )
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color getColor(double value) {
    return value < 0 ? Colors.red : Colors.green;
  }
}
