import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ipm_app/widgets/main_app_bar.dart';
import 'package:ipm_app/widgets/main_drawer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:requests/requests.dart';

import 'api/user.dart';
import 'login.dart';

class ReportsPage extends StatefulWidget {
  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  double dividerGap = 0.0;
  double height = 0.0;

  ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: backgroundColorIndigo,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      side: const BorderSide(color: Colors.black));

  User user = User.instance;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      dividerGap = 10;
      height = MediaQuery.of(context).size.height - 130;
    } else {
      dividerGap = 20;
      height = MediaQuery.of(context).size.height - 130;
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
                    'Vault Inventory',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: textColorGold,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: dividerGap - 10),
                      child: Image.asset(
                        'assets/images/logo_divide.png',
                        width: 320,
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
                SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        style: buttonStyle,
                        onPressed: () async {
                          var status = await Permission.storage.status;
                          print(status.isGranted);
                          if (!status.isGranted) {
                            await Permission.storage.request();
                          } else {
                            var r = await Requests.get(
                                'http://portal.demo.ipm.capital/mobileApi/data/pdf/inventory/${user.getVaultId}',
                                headers: {
                                  'Authorization': 'Bearer ${user.getToken}'
                                },
                                bodyEncoding:
                                    RequestBodyEncoding.FormURLEncoded);
                            final bytes = r.bodyBytes;
                            final directory =
                                await FilePicker.platform.getDirectoryPath();
                            final filePath =
                                '${directory}/vault_inventory_report.pdf';
                            final file = File(filePath);
                            try {
                              await file.writeAsBytes(bytes);
                            } on PathNotFoundException {}
                          }
                        },
                        child: const Text('Download report'))),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: Text(
                    'Vaulting Storage Cost Reports',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: textColorGold,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: dividerGap - 10),
                      child: Image.asset(
                        'assets/images/logo_divide.png',
                        width: 320,
                        fit: BoxFit.fill,
                      ),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 200,
                        child: ElevatedButton(
                            style: buttonStyle,
                            onPressed: () async {
                              var status = await Permission.storage.status;
                              print(status.isGranted);
                              if (!status.isGranted) {
                                await Permission.storage.request();
                              } else {
                                var r = await Requests.get(
                                    'http://portal.demo.ipm.capital/mobileApi/data/pdf/storageCosts/three/${user.getVaultId}',
                                    headers: {
                                      'Authorization': 'Bearer ${user.getToken}'
                                    },
                                    bodyEncoding:
                                        RequestBodyEncoding.FormURLEncoded);
                                final bytes = r.bodyBytes;
                                final directory = await FilePicker.platform
                                    .getDirectoryPath();
                                final filePath =
                                    '${directory}/3_months_storage_report.pdf';
                                final file = File(filePath);
                                try {
                                  await file.writeAsBytes(bytes);
                                } on PathNotFoundException {}
                              }
                            },
                            child: const Text('3 Months'))),
                    SizedBox(
                        width: 200,
                        child: ElevatedButton(
                            style: buttonStyle,
                            onPressed: () async {
                              var status = await Permission.storage.status;
                              print(status.isGranted);
                              if (!status.isGranted) {
                                await Permission.storage.request();
                              } else {
                                var r = await Requests.get(
                                    'http://portal.demo.ipm.capital/mobileApi/data/pdf/storageCosts/six/${user.getToken}',
                                    headers: {
                                      'Authorization': 'Bearer ${user.getToken}'
                                    },
                                    bodyEncoding:
                                        RequestBodyEncoding.FormURLEncoded);
                                final bytes = r.bodyBytes;
                                final directory = await FilePicker.platform
                                    .getDirectoryPath();
                                final filePath =
                                    '${directory}/6_months_storage_report.pdf';
                                final file = File(filePath);

                                try {
                                  await file.writeAsBytes(bytes);
                                } on PathNotFoundException {}
                              }
                            },
                            child: const Text('6 Months'))),
                    SizedBox(
                        width: 200,
                        child: ElevatedButton(
                            style: buttonStyle,
                            onPressed: () async {
                              var status = await Permission.storage.status;
                              print(status.isGranted);
                              if (!status.isGranted) {
                                await Permission.storage.request();
                              } else {
                                var r = await Requests.get(
                                    'http://portal.demo.ipm.capital/mobileApi/data/pdf/storageCosts/twelve/${user.getVaultId}',
                                    headers: {
                                      'Authorization': 'Bearer ${user.getToken}'
                                    },
                                    bodyEncoding:
                                        RequestBodyEncoding.FormURLEncoded);
                                final bytes = r.bodyBytes;
                                final directory = await FilePicker.platform
                                    .getDirectoryPath();
                                final filePath =
                                    '${directory}/12_months_storage_report.pdf';
                                final file = File(filePath);
                                try {
                                  await file.writeAsBytes(bytes);
                                } on PathNotFoundException {}
                              }
                            },
                            child: const Text('12 Months'))),
                  ],
                )
              ],
            ),
          ),
        ))),
      ),
    );
  }
}
