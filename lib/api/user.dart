import 'package:ipm_app/api/commodity.dart';
import 'package:ipm_app/api/injection.dart';
import 'package:requests/requests.dart';

class User {
  String _token = '';
  String _name = '';
  double _totalWeight = 0.0;
  double _totalValue = 0.0;
  final _commodities = [];
  final _injections = [];

  double get getTotalValue {
    return _totalValue;
  }

  double get getTotalWeight {
    return _totalWeight;
  }

  void get getCommodities {
    for (Commodity i in _commodities) {
      if (i.getValue > 0) {
        print(i.toString());
      }
    }
  }

  String get getName {
    return _name;
  }

  List get getInjections {
    return _injections;
  }

  set _setName(String newName) {
    if (_name.isEmpty) {
      _name = newName;
    }
  }

  String get getToken {
    return _token;
  }

  set _setToken(String newToken) {
    if (_token.isEmpty) {
      _token = newToken;
    }
  }

  static Future<User> createUser(String username, String password) async {
    User user = User();
    await user.asyncInit(username, password);
    return user;
  }

  Future<String> login(String username, String password) async {
    var r =
        await Requests.post('http://portal.demo.ipm.capital/mobileApi/login',
            body: {
              'username': username,
              'password': password,
            },
            bodyEncoding: RequestBodyEncoding.FormURLEncoded);
    if (r.statusCode == 200) {
      return r.json()['token'];
    } else {
      return r.json()['message'];
    }
  }

  Future<void> setup(String username, String password) async {
    _setToken = await login(username, password).then((value) => value);
    await initializeData();
  }

  asyncInit(String username, String password) async {
    await setup(username, password);
  }

  Future<void> initializeData() async {
    var r = await Requests.get(
        'https://portal.demo.ipm.capital/mobileApi/data/getUserData',
        headers: {'Authorization': 'Bearer $getToken'},
        bodyEncoding: RequestBodyEncoding.FormURLEncoded);
    dynamic json = r.json();
    _setName = json['alias'];
    _totalWeight = double.parse(json['holdingData']['totalWeight']);
    _totalValue = double.parse(json['holdingData']['totalValue']);
    for (dynamic commodity in json['holdingData']['holdings']) {
      _commodities.add(Commodity(
          commodity['commodity'],
          double.parse(commodity['commodityValue']),
          double.parse(commodity['value']),
          double.parse(commodity['valuePercentage']),
          double.parse(commodity['weight']),
          double.parse(commodity['totalCharges']),
          double.parse(commodity['totalChargesPercentage'])));
    }
    json['injectionData'].forEach((k, v) => (_injections.add(Injection(
        DateTime.parse(v['initialDate']),
        double.parse(v['currentInvestment']),
        double.parse(v['initialInvestment']),
        double.parse(v['valueChange']),
        v['valueChangePercentage'].toDouble(),
        double.parse(v['chargePercentage'])))));
  }
}
