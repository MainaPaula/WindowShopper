import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_shopper/screens/get_started_screen.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Account',style: TextStyle(fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold)),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.redAccent),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                      'Window',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold)),
                  const Text(
                      'Shopper',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 36, color: Colors.black, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 100),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
