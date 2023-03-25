import 'package:flutter/material.dart';
import 'package:ipm_app/api/injection.dart';

import 'api/user.dart';
import 'login.dart';

class SingleInjectionPage extends StatelessWidget {
  late final Injection injection;
  final User user = User.instance;

  SingleInjectionPage({Key? key, required this.injection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: backgroundColorIndigo,
        leading: ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColorIndigo),
            icon: const Icon(Icons.arrow_left_sharp),
            label: const Text('Back')),
      ),
      body: SingleChildScrollView(child: Padding(
        padding: EdgeInsets.zero,
        child: SizedBox(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Text(
                  'Injections - ${injection.getDate('dd-MM-yyyy')}',
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
                        horizontal: 20, vertical: 10),
                    child: Image.asset(
                      'assets/images/logo_divide.png',
                      width: 320,
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 25),
                child: FittedBox(
                  child: SizedBox(
                    height: 1200,
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
                          headingRowHeight: 200,
                          dataRowHeight: 200,
                          showCheckboxColumn: false,
                          headingRowColor: MaterialStateColor.resolveWith(
                            (states) => backgroundColorIndigo,
                          ),
                          dividerThickness: 2,
                          columns: [
                            DataColumn(
                              label: Text(
                                'Commodity',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: textColorGold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Current\n${user.getChosenCurrency} Value',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: textColorGold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Weight (${user.getChosenWeight})',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: textColorGold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '${user.getChosenCurrency} Value\nChange',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: textColorGold,
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                '${user.getChosenCurrency} Value Change\nPercentage',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: textColorGold,
                                ),
                              ),
                            ),
                            DataColumn(
                                label: Text(
                              'Initial ${user.getChosenCurrency} Paper\nValuation',
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: textColorGold,
                              ),
                            ))
                          ],
                          rows: injection.getSubInjectionRows(),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
