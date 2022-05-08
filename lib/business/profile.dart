import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/get_started_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Account",style: TextStyle(fontSize: 27, color: Colors.black, fontWeight: FontWeight.bold)),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.redAccent),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.expand,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.black12,
                  //backgroundImage: AssetImage(''),
                ),
                Positioned(
                  bottom: 0,
                  right: -12,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: const Icon(Icons.camera_alt),
                      color: Colors.redAccent,
                    )
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: MaterialButton(
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              color: Color(0xFFF5F6F9),
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.person_outline_outlined, color: Colors.redAccent),
                  SizedBox(width: 20),
                  Expanded(
                      child: Text(
                        "Account Details",
                        style: Theme.of(context).textTheme.bodyText1,)
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.redAccent),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: MaterialButton(
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
              color: Color(0xFFF5F6F9),
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.my_library_books, color: Colors.redAccent),
                  SizedBox(width: 20),
                  Expanded(
                      child: Text(
                        "Privacy Policy",
                        style: Theme.of(context).textTheme.bodyText1,)
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.redAccent),
                ],
              ),
            ),
          ),SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: MaterialButton(
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
              color: Color(0xFFF5F6F9),
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.my_library_books, color: Colors.redAccent),
                  SizedBox(width: 20),
                  Expanded(
                      child: Text(
                        "Terms & Conditions",
                        style: Theme.of(context).textTheme.bodyText1,)
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.redAccent),
                ],
              ),
            ),
          ),SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: MaterialButton(
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
              color: Color(0xFFF5F6F9),
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.headphones, color: Colors.redAccent),
                  SizedBox(width: 20),
                  Expanded(
                      child: Text(
                        "Help and Support",
                        style: Theme.of(context).textTheme.bodyText1,)
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.redAccent),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: MaterialButton(
              padding: EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
              color: Color(0xFFF5F6F9),
              onPressed: () async {
                final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                sharedPreferences.remove('email');
                Navigator.push(context, MaterialPageRoute(builder: (context) => const GetStartedScreen()));
              },
              child: Row(
                children: [
                  Icon(Icons.logout, color: Colors.redAccent),
                  SizedBox(width: 20),
                  Expanded(
                      child: Text(
                        "Log out",
                        style: Theme.of(context).textTheme.bodyText1,)
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.redAccent),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
