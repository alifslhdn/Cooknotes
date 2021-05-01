import 'package:cooknotes/module1_screen/splash_screen.dart';
import 'package:cooknotes/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cooknotes/dependencies.dart' as di;

void main() {
  di.init();
  runApp(ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (context) => ValueNotifier(true),
      child: Consumer<ValueNotifier<bool>>(
          builder: (_, notifier, __) => MaterialApp(
                onGenerateRoute: createRoute,
                title: 'Cook Notes Demo',
                debugShowCheckedModeBanner: false,
                theme: notifier.value
                    ? ThemeData(primaryColor: Colors.white)
                    : ThemeData(
                        // primaryColor: Colors.black,
                        scaffoldBackgroundColor: Colors.black,
                        accentColor: Color(0xff00556A),
                        bottomNavigationBarTheme: BottomNavigationBarThemeData(
                            backgroundColor: Colors.black,
                            unselectedItemColor: Colors.white),
                        inputDecorationTheme: InputDecorationTheme(
                          fillColor: Colors.white,
                        ),
                        textTheme: TextTheme(
                            bodyText2: TextStyle(color: Colors.white)),
                        cardColor: Colors.grey,
                        dividerTheme: DividerThemeData(color: Colors.white),
                        appBarTheme: AppBarTheme(color: Colors.black)),
                home: SplashScreens(),
              ))));
}
