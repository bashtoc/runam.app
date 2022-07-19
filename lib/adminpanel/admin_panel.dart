import 'package:flutter/material.dart';
import 'package:runam/constants/color_const.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:runam/screens/login.dart';

import '../database/user_management.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
           Text(
            'Admin Panel', style: TextStyle(color: primaryColor),
          ),
          const SizedBox(
            width: 80,
          ),
          IconButton(
              icon:  Icon(
                Icons.logout,
                color: primaryColor,
              ),
              onPressed: () {
                // set up the button
                Widget action = TextButton(
                  child: const Text("OppK"),
                  onPressed: () {},
                );

                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: const Text("Logout"),
                  content: const Text("Are you sure you want to logout"),
                  actions: [
                    action = TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No')),
                    action = TextButton(
                        onPressed: () {
                          DbHelper().signOut();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (_) => const Login()),
                                  (route) => false);
                        },
                        child: const Text('yes')),
                  ],
                );

                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              }),
        ]),
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset('assets/addbet.svg', height: 100,),
                SvgPicture.asset('assets/buyrequest.svg', height: 100,),
              ],
            )
          ],
        ),
      ),
    );
  }
}
