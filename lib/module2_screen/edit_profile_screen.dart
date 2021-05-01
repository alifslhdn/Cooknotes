import 'package:cooknotes/models/user.dart';
import 'package:cooknotes/services/user_data_service.dart';
import 'package:cooknotes/services/user_rest_service.dart';
import 'package:cooknotes/widget/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';
import '../dependencies.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen();
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _pageIndex = 2;
  String _username;
  String _displayName;
  String _email;
  String _password;
  int _age;
  bool showPass = false;

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
            padding: const EdgeInsets.all(20.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30),
                new Text(' Edit Profile',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 25.0,
                        fontFamily: 'Lato Black',
                        color: new Color(0xff00556A),
                        fontWeight: FontWeight.bold)),
                Container(
                  child: new Card(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Form(
                            key: _formKey,
                            child: new Column(
                              children: <Widget>[
                                SizedBox(height: 20),
                                CircleAvatar(
                                  backgroundColor: Color(0xffE6E6E6),
                                  backgroundImage: AssetImage(user.profilePic),
                                  radius: 40,
                                ),
                                SizedBox(height: 10),
                                RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0)),
                                    child: Text('Change Image'),
                                    onPressed: () {}),
                                SizedBox(height: 20),
                                Container(
                                    child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    _buildUserName(),
                                    _buildDisplayName(),
                                    SizedBox(height: 15),
                                    _buildEmail(),
                                    SizedBox(height: 15),
                                    _buildPassword(true),
                                    SizedBox(height: 15),
                                    _buildAge(),
                                    SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RaisedButton(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 40.0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0)),
                                            color: new Color(0xff00556A),
                                            textColor: Colors.white,
                                            child: Text('Save Changes'),
                                            onPressed: () {
                                              if (!_formKey.currentState
                                                  .validate()) {
                                                return;
                                              }
                                              _formKey.currentState.save();
                                              print('Username: ' + _username);
                                              print('Display name: ' +
                                                  _displayName);
                                              print('Email: ' + _email);
                                              print('Password: ' + _password);
                                              print('Age: ' + _age.toString());

                                              user.username = _username;
                                              user.displayName = _displayName;
                                              user.email = _email;
                                              user.password = _password;
                                              user.age = _age;

                                              Navigator.pushReplacementNamed(
                                                  context, profileRoute);
                                            }),
                                      ],
                                    ),
                                    SizedBox(height: 30),
                                  ],
                                ))
                              ],
                            ),
                          ))),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Navbar(_pageIndex));
  }

  Widget textField(String labelText, String hintText, bool isPassed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: TextField(
        obscureText: isPassed ? showPass : false,
        decoration: InputDecoration(
            suffixIcon: isPassed
                ? IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    color: Colors.black,
                    onPressed: () {
                      setState(() {
                        showPass = !showPass;
                      });
                    },
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: hintText,
            labelStyle: TextStyle(
              fontSize: 25.0,
              fontFamily: 'Lato Black',
              color: new Color(0xff00556A),
              fontWeight: FontWeight.bold,
            ),
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            )),
      ),
    );
  }

  Widget _buildUserName() {
    return TextFormField(
      initialValue: user.username,
      decoration: InputDecoration(
        labelText: 'Username',
        hintText: user.username,
        contentPadding: EdgeInsets.only(bottom: 3),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(
          fontSize: 25.0,
          fontFamily: 'Lato Black',
          color: new Color(0xff00556A),
          fontWeight: FontWeight.bold,
        ),
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
      maxLength: 20,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Username is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _username = value;
      },
    );
  }

  Widget _buildDisplayName() {
    return TextFormField(
      initialValue: user.displayName,
      decoration: InputDecoration(
        labelText: 'Display Name',
        hintText: user.displayName,
        contentPadding: EdgeInsets.only(bottom: 3),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(
          fontSize: 25.0,
          fontFamily: 'Lato Black',
          color: new Color(0xff00556A),
          fontWeight: FontWeight.bold,
        ),
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _displayName = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      initialValue: user.email,
      decoration: InputDecoration(
          labelText: 'Email',
          hintText: user.email,
          contentPadding: EdgeInsets.only(bottom: 3),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(
            fontSize: 25.0,
            fontFamily: 'Lato Black',
            color: new Color(0xff00556A),
            fontWeight: FontWeight.bold,
          )),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }

        if (!RegExp(
                r"[a-z0-9!#$%&'+/=?^`{|}~-]+(?:.[a-z0-9!#$%&'+/=?^`{|}~-]+)@(?:[a-z0-9](?:[a-z0-9-][a-z0-9])?.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(value)) {
          return 'Please enter a valid email Address';
        }

        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildPassword(bool isPassed) {
    return TextFormField(
      initialValue: user.password,
      obscureText: !showPass,
      decoration: InputDecoration(
        suffixIcon: isPassed
            ? IconButton(
                icon: Icon(Icons.remove_red_eye),
                color: Colors.black,
                onPressed: () {
                  setState(() {
                    showPass = !showPass;
                  });
                },
              )
            : null,
        labelText: 'Password',
        hintText: user.password,
        contentPadding: EdgeInsets.only(bottom: 3),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(
          fontSize: 25.0,
          fontFamily: 'Lato Black',
          color: new Color(0xff00556A),
          fontWeight: FontWeight.bold,
        ),
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  Widget _buildAge() {
    return TextFormField(
      keyboardType: TextInputType.number,
      initialValue: user.age.toString(),
      decoration: InputDecoration(
        labelText: 'Age',
        hintText: user.age.toString(),
        contentPadding: EdgeInsets.only(bottom: 3),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(
          fontSize: 25.0,
          fontFamily: 'Lato Black',
          color: new Color(0xff00556A),
          fontWeight: FontWeight.bold,
        ),
        hintStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700],
        ),
      ),
      maxLength: 2,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Age is Required';
        }

        return null;
      },
      onSaved: (String value) {
        _age = int.parse(value);
      },
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
