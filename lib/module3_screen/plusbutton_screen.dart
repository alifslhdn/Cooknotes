import 'package:cooknotes/models/user.dart';
import 'package:cooknotes/services/user_data_service.dart';
import 'package:cooknotes/services/user_rest_service.dart';
import 'package:cooknotes/widget/appbar.dart';
import 'package:cooknotes/widget/navbar.dart';
import '../constants.dart';
import 'package:cooknotes/module3_screen/create_recipe_screen.dart';
import 'package:flutter/material.dart';

import '../dependencies.dart';

class PlusButtonScreen extends StatefulWidget {
  PlusButtonScreen();

  @override
  _PlusButtonScreenState createState() => _PlusButtonScreenState();
}

class _PlusButtonScreenState extends State<PlusButtonScreen> {
  int _pageIndex = 1;
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
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0), child: Appbar()),
        body: new Container(
          padding: EdgeInsets.all(20),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Card(
                child: new InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, createRecipeRoute);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: new Column(
                      children: <Widget>[
                        new Image.asset('assets/cook.png',
                            height: 100, width: 100),
                        new Text('Create a new recipe',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Color(0xff00556A),
                                fontFamily: 'Lato Black')),
                      ],
                    ),
                  ),
                ),
              ),
              user.usertype == 'C' ? newArticleCard() : Container(),
            ],
          ),
        ),
        bottomNavigationBar: Navbar(_pageIndex));
  }

  newArticleCard() {
    return Card(
      child: new InkWell(
        onTap: () {
          Navigator.pushNamed(context, createArticleRoute);
        },
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: new Column(
            children: <Widget>[
              new Image.asset('assets/article.png', height: 100, width: 100),
              new Text('Create a new article',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xff00556A),
                      fontFamily: 'Lato Black')),
            ],
          ),
        ),
      ),
    );
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
