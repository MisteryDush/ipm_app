import 'package:flutter/material.dart';
import 'api/user.dart';

void main() => runApp(const MyApp());

const Color textColorGold = Color.fromRGBO(209, 142, 48, 1);
const Color backgroundColorIndigo = Color.fromRGBO(49, 0, 94, 100);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = '';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: Scaffold(
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
                          horizontal: 50, vertical: 20),
                      side: const BorderSide(color: textColorGold)),
                  child: const Text('Login'),
                  onPressed: () async {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) {
                          return Dialog(
                            // The background color
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
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
                                  Text('Loading...')
                                ],
                              ),
                            ),
                          );
                        });
                    print(nameController.text.isEmpty);
                    print(passwordController.text.isEmpty);
                    if (nameController.text.isEmpty |
                        passwordController.text.isEmpty) {
                      print('Blank!');
                      Navigator.of(context).pop();
                      return;
                    }
                    print('Logging in...');
                    User user = await User.createUser(
                        nameController.text, passwordController.text);
                    Navigator.of(context).pop();
                    print('Welcome ${user.getName} !');
                    print('Total weight: ${user.getTotalWeight}');
                    print('Total value: \$${user.getTotalValue}');
                    print('You have these commodities:');
                    user.getCommodities;
                    print(user.getInjections);
                  },
                )),
          ],
        ));
  }
}
