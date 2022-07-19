import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:runam/screens/login.dart';
import 'package:runam/screens/password_reset.dart';

import '../constants/color_const.dart';
import '../widgets/custom_container.dart';

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

User? user = FirebaseAuth.instance.currentUser;

class _ProfileState extends State<Profile> {
  CollectionReference dbCollection = FirebaseFirestore.instance
      .collection('users')
      .doc(user?.uid)
      .collection('usersInfo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot>(
        stream: dbCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error fetching data'),
                );
              }
              return const Center(
                child: Text(
                  'No user defined !',
                  style: TextStyle(fontSize: 19, color: Colors.grey),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: 1,
                reverse: false,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ...snapshot.data!.docs.map((data) {
                        String lastName = data.get('lastName');
                        String firstName = data.get('firstName');

                        return Container(
                            margin: const EdgeInsets.only(left: 25, right: 25),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Username',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: primaryColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomContainer(
                                  containerChild: Row(
                                    children: [
                                      Text(
                                        firstName,
                                        style: TextStyle(
                                            fontSize: 18, color: primaryColor),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        lastName,
                                        style: TextStyle(
                                            fontSize: 18, color: primaryColor),
                                      ),
                                    ],
                                  ),
                                  padding:
                                      const EdgeInsets.only(top: 0, left: 30),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Password',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: primaryColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                CustomContainer(
                                  containerChild: Row(
                                    children: const [
                                      Text(
                                        '**********',
                                      ),
                                    ],
                                  ),
                                  padding:
                                      const EdgeInsets.only(top: 0, left: 30),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ResetPassword()));
                                      },
                                      child: Text(
                                        'Reset',
                                        style: TextStyle(color: primaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Login()),
                                        (route) => false);
                                  },
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: primaryColor),
                                  ),
                                )
                              ],
                            ));
                      }),
                    ],
                  );
                },
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
