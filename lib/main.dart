import 'package:flutter/material.dart';
import 'package:loginapp/loginPage.dart';
import 'package:loginapp/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: splashPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  static const String NameKey = "uname";
  static const String EmailKey = "uemail";

  var uNameValue = "Name is not Present";
  var uEmailValue = "Email is not Present";

  @override
  void initState() {
    getValue();
    super.initState();
  }

  void getValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var namevalue = prefs.getString(NameKey);
    var emailvalue = prefs.getString(EmailKey);

    uNameValue = namevalue ?? "Name is not Present";
    uEmailValue = emailvalue ?? "Email is not Present";

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('HomePage')),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromARGB(31, 175, 149, 149),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  child: Icon(
                    Icons.account_box_rounded,
                    size: 50,
                  ),
                  radius: 40.0),
              SizedBox(height: 11),
              Text(
                uNameValue,
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 11),
              Text(
                uEmailValue,
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 11),
              ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool(splashPageState.loginKey, false);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => loginPage()));
                  },
                  child: Text('Logout', style: TextStyle(fontSize: 18)))
            ],
          ),
        ));
  }
}
