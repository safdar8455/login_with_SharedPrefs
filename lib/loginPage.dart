import 'package:flutter/material.dart';
import 'package:loginapp/main.dart';
import 'package:loginapp/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class loginPage extends StatefulWidget {
  @override
  State<loginPage> createState() => _loginPage();
}

class _loginPage extends State<loginPage> {
  var userContrl = TextEditingController();
  var emailContrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Login Page')),
      ),
      body: Container(
        child: Center(
            child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: userContrl,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  label: Text('User'),
                  prefixIcon: Icon(Icons.account_box_rounded),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 11),
              TextField(
                controller: emailContrl,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  label: Text('Email'),
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 11),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                obscuringCharacter: '#',
                decoration: InputDecoration(
                  label: Text('Password'),
                  prefixIcon: Icon(Icons.password),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 11),
              ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString(
                        MyHomePageState.NameKey, userContrl.text.toString());
                    prefs.setString(
                        MyHomePageState.EmailKey, emailContrl.text.toString());
                    prefs.setBool(splashPageState.loginKey, true);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                    setState(() {});
                  },
                  child: Text('Login')),
            ],
          ),
        )),
      ),
    );
  }
}
