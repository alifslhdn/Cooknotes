import 'package:cooknotes/services/user_data_service.dart';
import 'package:cooknotes/services/user_rest_service.dart';
import 'package:cooknotes/widget/appbar.dart';
import 'package:cooknotes/widget/navbar.dart';
import 'package:flutter/material.dart';
import 'package:cooknotes/models/user.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../dependencies.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen();
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int _pageIndex = 3;
  User user;

  @override
  Widget build(BuildContext context) {
    final userDataService = UserRestService();

    return FutureBuilder<User>(
        future: userDataService.getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            user = snapshot.data;
            return _buildMainScreen();
          }
          return _buildFetchingDataScreen();
        });
  }

  Scaffold _buildMainScreen() {
    final changeModeNotifier = Provider.of<ValueNotifier<bool>>(context);
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0), child: Appbar()),
        body: SingleChildScrollView(
          child: new Container(
            padding: const EdgeInsets.all(20.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text('Settings',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'Lato Black',
                        color: new Color(0xff00556A),
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Container(
                  child: new Card(
                    child: new Column(
                      children: <Widget>[
                        SizedBox(height: 15),
                        CheckboxListTile(
                          title: Text('Change Theme Color',
                              style: TextStyle(
                                  fontFamily: 'Lato Black',
                                  fontWeight: FontWeight.bold)),
                          subtitle: changeModeNotifier.value
                              ? Text('Light Mode')
                              : Text('Dark Mode'),
                          value: changeModeNotifier.value,
                          onChanged: (newValue) =>
                              changeModeNotifier.value = newValue,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Navbar(_pageIndex));
  }

  Scaffold _buildFetchingDataScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 50),
            Text('Fetching recipe... Please wait'),
          ],
        ),
      ),
    );
  }
}
