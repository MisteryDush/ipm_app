import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipm_app/settings.dart';
import 'api/user.dart';
import 'menu.dart';
import 'injections_page.dart';
import 'historical_vault_page.dart';
import 'cost_charges_page.dart';
import 'reports_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]).then((value) => runApp(MyApp()));
  runApp(const MyApp());
}

const Color textColorGold = Color.fromRGBO(209, 142, 48, 1);
const Color backgroundColorIndigo = Color.fromRGBO(49, 0, 94, 1);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      initialRoute: '/',
      routes: {
        '/menu': (context) => Menu(),
        '/settings': (context) => SettingsPage(),
        '/historical_vault_page': (context) => HistoricalVaultPage(),
        '/cost_charges_page': (context) => CostChargesPage(),
        '/injections_page': (context) => InjectionsPage(),
        '/reports_page': (context) => ReportsPage(),
      },
      home: const Scaffold(
        backgroundColor: backgroundColorIndigo,
        body: LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/logo_and_name.png',
                  fit: BoxFit.contain,
                  height: 100,
                  width: 250,
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 20, color: textColorGold),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                style: const TextStyle(color: textColorGold),
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    labelStyle: TextStyle(color: textColorGold)),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: TextField(
                obscureText: true,
                style: const TextStyle(color: Color.fromRGBO(209, 142, 48, 1)),
                controller: passwordController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: textColorGold)),
              ),
            ),
            Container(
                alignment: Alignment.center,
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: textColorGold,
                      backgroundColor: backgroundColorIndigo,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      side: const BorderSide(color: textColorGold)),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () async {
                    if (nameController.text.isEmpty |
                    passwordController.text.isEmpty) {
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (_) {
                            return Dialog(
                              // The background color
                              backgroundColor: backgroundColorIndigo,
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 40),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    // The loading indicator
                                    // Some text
                                    Text(
                                      'Please enter username and password',
                                      style: TextStyle(
                                          color: textColorGold, fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      bool isSuccess = true;
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) {
                            return Dialog(
                              // The background color
                              backgroundColor: backgroundColorIndigo,
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    // The loading indicator
                                    CircularProgressIndicator(
                                      color: textColorGold,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    // Some text
                                    Text(
                                      'Loading...',
                                      style: TextStyle(color: textColorGold),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                      try {
                        await User.createUser(
                            nameController.text, passwordController.text);
                      } on LoginException {
                        Navigator.of(context).pop();
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (_) {
                              return Dialog(
                                // The background color
                                backgroundColor: backgroundColorIndigo,
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      // Some text
                                      Text(
                                        'Invalid credentials, try again.',
                                        style: TextStyle(
                                            color: textColorGold, fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                        isSuccess = false;
                      } on TimeoutException {
                        Navigator.of(context).pop();
                        showDialog(
                            barrierDismissible: true,
                            context: context,
                            builder: (_)
                        {
                          return Dialog(
                            // The background color
                            backgroundColor: backgroundColorIndigo,
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  // Some text
                                  Text(
                                    'Connection problems. Please, try again.',
                                    style: TextStyle(
                                        color: textColorGold, fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                      }
                      finally {
                        if (isSuccess) {
                          Navigator.of(context).pop();
                          Navigator.popAndPushNamed(context, '/menu');
                        }
                      }
                    }
                  },
                )),
          ],
        ));
  }
}
