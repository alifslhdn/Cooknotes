import 'package:cooknotes/models/article.dart';
import 'package:cooknotes/models/recipe.dart';
import 'package:cooknotes/models/user.dart';
import 'package:cooknotes/services/user_data_service.dart';
import 'package:cooknotes/services/user_rest_service.dart';
import 'package:flutter/services.dart';
import '../constants.dart';
import 'package:flutter/material.dart';
import '../dependencies.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  String _displayname;
  String _username;
  String _password;
  String _email;
  int _age;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final userDataService = UserRestService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              Container(
                //height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Register',
                        style: TextStyle(
                          color: Color(0xff00556A),
                          fontFamily: 'Lato Bold',
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      _buildDisplayName(),
                      _buildUsername(),
                      _buildPassword(),
                      _buildEmailandAge(),
                      _buildRegisterBtn(),
                      _buildLoginText(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDisplayName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.person,
                    color: Color(0xff00556A),
                  ),
                  onPressed: null),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(right: 20, left: 10),
                      child: TextFormField(
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Display Name is required';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          _displayname = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Display Name',
                          hintStyle: TextStyle(
                            color: Color(0xff00556A),
                            fontFamily: 'Lato',
                          ),
                        ),
                      )))
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUsername() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.person,
                    color: Color(0xff00556A),
                  ),
                  onPressed: null),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(right: 20, left: 10),
                      child: TextFormField(
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Username is required';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          _username = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Username',
                          hintStyle: TextStyle(
                            color: Color(0xff00556A),
                            fontFamily: 'Lato',
                          ),
                        ),
                      )))
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.lock,
                    color: Color(0xff00556A),
                  ),
                  onPressed: null),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(right: 20, left: 10),
                      child: TextFormField(
                        obscureText: true,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          _password = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Color(0xff00556A),
                            fontFamily: 'Lato',
                          ),
                        ),
                      )))
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmailandAge() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.mail,
                    color: Color(0xff00556A),
                  ),
                  onPressed: null),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(right: 20, left: 10),
                      child: TextFormField(
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          _email = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Color(0xff00556A),
                            fontFamily: 'Lato',
                          ),
                        ),
                      )))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.mail,
                    color: Color(0xff00556A),
                  ),
                  onPressed: null),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(right: 20, left: 10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          new LengthLimitingTextInputFormatter(2),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Age is required';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          _age = int.parse(value);
                        },
                        decoration: InputDecoration(
                          hintText: '18',
                          hintStyle: TextStyle(
                            color: Color(0xff00556A),
                            fontFamily: 'Lato',
                          ),
                        ),
                      )))
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          print('Register Button Pressed');
          if (!_formKey.currentState.validate()) {
            return;
          }
          _formKey.currentState.save();
          User newUser = new User(
              username: _username,
              displayName: _displayname,
              profilePic: "assets/tony.png",
              usertype: "U",
              age: _age,
              email: _email,
              password: _password,
              recipe: [
                Recipe(
                    foodName: "default",
                    image: 'assets/asampedas.jpg',
                    prepHours: 0,
                    prepMins: 30,
                    cookHours: 1,
                    cookMins: 30,
                    numPerson: 5,
                    ingredients: "default ingredient",
                    instruction: "defailt instruction")
              ],
              article: [
                Article(title: "", image: "", author: "", content: "")
              ]);

          userDataService.addUser(newUser);
          Navigator.pushReplacementNamed(context, homeRoute);
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color(0xff00556A),
        child: Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Lato',
          ),
        ),
      ),
    );
  }

  Widget _buildLoginText() {
    return Row(
      children: <Widget>[
        Text(
          '     Already have an account ? ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        TextButton(
            child: Text(
              'Login',
              style: TextStyle(
                color: Color(0xff00556A),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, loginRoute);
            })
      ],
    );
  }
}
