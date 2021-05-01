import 'package:cooknotes/models/recipe.dart';
import 'package:cooknotes/models/user.dart';
import 'package:cooknotes/services/user_data_service.dart';
import 'package:cooknotes/services/user_rest_service.dart';
import 'package:cooknotes/widget/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../dependencies.dart';

class DisplayRecipeScreen extends StatefulWidget {
  DisplayRecipeScreen();

  @override
  _DisplayRecipeScreenState createState() => _DisplayRecipeScreenState();
}

class _DisplayRecipeScreenState extends State<DisplayRecipeScreen> {
  int _pageIndex = 0;
  Recipe recipe;
  final userDataService = UserRestService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Recipe>(
        future: userDataService.getRecipe(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            recipe = snapshot.data;
            return _buildMainScreen();
          }
          return _buildFetchingDataScreen();
        });
  }

  Scaffold _buildMainScreen() {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, color: Color(0xff00556A)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: true,
            elevation: 0,
            title: Text('COOKNOTES',
                style: TextStyle(
                    color: Color(0xff00556A), fontFamily: 'Montserrat Black')),
            actions: <Widget>[
              FlatButton(
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, logoutRoute, (_) => false);
                },
                child: Text("Logout",
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Color(0xff00556A),
                        fontFamily: 'Lato Black')),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.transparent)),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: new Container(
            padding: EdgeInsets.all(30),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(recipe.foodName.toUpperCase(),
                    style: TextStyle(
                        fontSize: 35.0,
                        color: Color(0xff00556A),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato Black')),
                SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    recipe.image,
                    height: 150,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                new Container(
                    child: Divider(
                  height: 40,
                )),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Column(
                      children: <Widget>[
                        new Icon(Icons.person,
                            size: 50, color: Colors.amber[800]),
                        new Text("Servings",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Color(0xff00556A),
                                fontFamily: 'Lato Black')),
                        new Text(recipe.numPerson.toString() + " person",
                            style: TextStyle(
                                fontSize: 15.0, fontFamily: 'Lato Black'))
                      ],
                    ),
                    SizedBox(width: 40),
                    new Column(
                      children: <Widget>[
                        new Icon(Icons.kitchen, size: 50, color: Colors.red),
                        new Text("Prep Time",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Color(0xff00556A),
                                fontFamily: 'Lato Black')),
                        new Text(
                            recipe.prepHours.toString() +
                                " hour\n" +
                                recipe.prepMins.toString() +
                                " minutes",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0, fontFamily: 'Lato Black'))
                      ],
                    ),
                    SizedBox(width: 40),
                    new Column(
                      children: <Widget>[
                        new Icon(Icons.restaurant_menu,
                            size: 50, color: Colors.blue),
                        new Text("Cook Time",
                            style: TextStyle(
                                fontSize: 15.0,
                                color: Color(0xff00556A),
                                fontFamily: 'Lato Black')),
                        new Text(
                            recipe.cookHours.toString() +
                                " hour \n" +
                                recipe.cookMins.toString() +
                                " minutes",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15.0, fontFamily: 'Lato Black'))
                      ],
                    )
                  ],
                ),
                new Container(
                    child: Divider(
                  height: 30,
                )),
                new Text('Ingredients',
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Color(0xff00556A),
                        fontFamily: 'Lato Black')),
                SizedBox(height: 10),
                new Text(recipe.ingredients,
                    style: TextStyle(fontSize: 20.0, fontFamily: 'Lato Black')),
                new Container(
                    child: Divider(
                  height: 30,
                )),
                new Text('Instruction',
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Color(0xff00556A),
                        fontFamily: 'Lato Black')),
                SizedBox(height: 10),
                new Text(recipe.instruction,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 20.0, fontFamily: 'Lato Black')),
                SizedBox(height: 30),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new IconButton(
                        iconSize: 30,
                        icon: Icon(Icons.edit, color: Color(0xff00556A)),
                        onPressed: () {
                          Navigator.pushNamed(context, updateRecipeRoute);
                        }),
                    SizedBox(width: 20),
                    new IconButton(
                        iconSize: 30,
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Delete Recipe"),
                                  content: Text(
                                      "Are you sure want to delete this recipe?"),
                                  actions: [
                                    FlatButton(
                                      child: Text("Yes",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Color(0xff00556A),
                                              fontFamily: 'Lato Black')),
                                      onPressed: () async {
                                        userDataService.removeRecipe(recipe);
                                        final updatedUser =
                                            await userDataService.updateUser();
                                        userDataService.setUser(updatedUser);
                                        Navigator.pop(context);
                                        Navigator.pushNamed(context, homeRoute);
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("No",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.red,
                                              fontFamily: 'Lato Black')),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        }),
                  ],
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
