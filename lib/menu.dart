import 'package:flutter/cupertino.dart';

import 'api/user.dart';

class Menu extends StatelessWidget {
  User user = User.instance;

  @override
  Widget build(BuildContext context) {
    print('Welcome ${user.getName} !');
    print('Total weight: ${user.getTotalWeight}');
    print('Total value: \$${user.getTotalValue}');
    print('You have these commodities:');
    user.getCommodities;
    print(user.getInjections);
    return const Text("Hi!");
  }

}
