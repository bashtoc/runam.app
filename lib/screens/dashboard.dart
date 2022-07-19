import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:runam/screens/prediction.dart';

import '../constants/color_const.dart';
import 'notifications.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

User? user = FirebaseAuth.instance.currentUser;
CollectionReference dbCollection = FirebaseFirestore.instance
    .collection('users')
    .doc(user?.uid)
    .collection('usersInfo');

var elevatedButton = ElevatedButton.styleFrom(primary: primaryColor);

String balance = '40,156.45';

bool newText = false;

bool showErrorMessage = false;
bool showErrorMessag = false;
bool showErrorMessages = false;

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
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
                                String firstName = data.get('firstName');

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () {},

                                      ///username here
                                      child: Text(
                                        'Hello $firstName !',
                                        style: TextStyle(
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    IconButton(
                                      icon: (Icon(
                                        Icons.notifications,
                                        color: primaryColor,
                                      )),
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Notifications()));
                                      },
                                    )
                                  ],
                                );
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
              Stack(children: [
                Image.asset('assets/walletBackground.png'),
                Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      top: 10,
                    ),
                    child: const Text(
                      'USDT WALLET',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    )),
                Positioned(
                    left: 300,
                    bottom: 140,
                    child: IconButton(
                      icon: const Icon(
                        Icons.remove_red_eye,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    )),

                ///blockchain wallet balance
                Positioned(
                  top: 70,
                  left: 90,
                  child: Text(
                    '\$ $balance',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                const Positioned(
                  child: Text(
                    'available balance',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  top: 120,
                  left: 110,
                ),
              ]),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      style: elevatedButton,
                      onPressed: () {},
                      child: Row(
                        children: const [
                          Icon(Icons.call_received),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Receive'),
                        ],
                      )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      onPressed: () {},
                      child: Row(
                        children: const [
                          Icon(Icons.call_made_rounded),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Send'),
                        ],
                      )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Prediction()));
                    },
                    ///football predict image
                    child: SvgPicture.asset(
                      'assets/footballpredict.svg',
                      height: 100,
                    ),
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          newText = !newText;
                          if (newText == true) {
                            setState(() {
                              showErrorMessage = true;
                            });
                          } else {
                            setState(() {
                              showErrorMessage = false;
                            });
                          }
                        },

                        ///wrestle predict image
                        child: SvgPicture.asset(
                          'assets/wrestlepredict.svg',
                          height: 100,
                        ),
                      ),
                      Positioned(
                        top: 70,
                        child: showErrorMessage
                            ? Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(80.0)),
                                child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'coming soon',
                                      style: TextStyle(color: Colors.red),
                                    )))
                            : Container(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          newText = !newText;
                          if (newText == true) {
                            setState(() {
                              showErrorMessages = true;
                            });
                          } else {
                            setState(() {
                              showErrorMessages = false;
                            });
                          }
                        },

                        ///giveaway  image
                        child: SvgPicture.asset(
                          'assets/giveaway.svg',
                          height: 100,
                        ),
                      ),
                      Positioned(
                        top: 70,
                        child: showErrorMessages
                            ? Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(80.0)),
                                child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'coming soon',
                                      style: TextStyle(color: Colors.red),
                                    )))
                            : Container(),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          newText = !newText;
                          if (newText == true) {
                            setState(() {
                              showErrorMessag = true;
                            });
                          } else {
                            setState(() {
                              showErrorMessag = false;
                            });
                          }
                        },
                        ///p2p ,market image
                        child: SvgPicture.asset(
                          'assets/peer2peer.svg',
                          height: 100,
                        ),
                      ),
                      Positioned(
                        top: 70,
                        child: showErrorMessag
                            ? Container(
                                decoration: BoxDecoration(
                                    // color: Colors.red,
                                    borderRadius: BorderRadius.circular(80.0)),
                                child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'coming soon',
                                      style: TextStyle(color: Colors.red),
                                    )))
                            : Container(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
