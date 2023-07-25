import 'dart:async';

import 'package:flutter/material.dart';
import 'package:loginapp/loginPage.dart';
import 'package:loginapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splashPage extends StatefulWidget {
  @override
  State<splashPage> createState() => splashPageState();
}

class splashPageState extends State<splashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _showWelcome = false;
  static const String loginKey = "login";

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.addListener(() {
      setState(() {});
      if (_animationController.status == AnimationStatus.completed) {
        setState(() {
          radius.removeAt(0);
          _animationController.reset();
          _showWelcome = true;
        });
        Future.delayed(Duration(seconds: 2), () {
          if (_showWelcome) {
            whereToGo();
          }
        });
      }
    });

    _animationController.forward();

    super.initState();
  }

  void _navigateToLoginPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => loginPage(),
      ),
    );
  }

  void whereToGo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLogIn = prefs.getBool(loginKey);
    if (isLogIn != null) {
      if (isLogIn) {
        _navigateToHomePage();
      } else {
        _navigateToLoginPage();
      }
    } else {
      _navigateToLoginPage();
    }
  }

  void _navigateToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(),
      ),
    );
  }

  var radius = [
    10.0,
    20.0,
    40.0,
    80.0,
    120.0,
    150.0,
    175.0,
    200.0,
    250.0,
    300.0,
    350.0
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromARGB(255, 0, 20, 1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                  alignment: Alignment.center,
                  children: radius
                      .map((raduis) => Container(
                            width: _animationController.value * raduis,
                            height: _animationController.value * raduis,
                            decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(
                                    1 - _animationController.value),
                                shape: BoxShape.circle),
                          ))
                      .toList()),
              AnimatedOpacity(
                opacity: _showWelcome ? 1.0 : 0.0,
                duration: Duration(seconds: 1),
                child: Text(
                  'WELCOME',
                  style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
