
import 'package:flutter/material.dart';

import '../constants/color_const.dart';
import '../constants/container_constants.dart';

class Prediction extends StatelessWidget {
  const Prediction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 75,
              ),
              const Text(
                'Prediction',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          )),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(

            margin: const EdgeInsets.only(left: 20,right: 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 30,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],

            ),
            height: 193,
            width: 390,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Who will win this match?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/chelsea.png', ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Chelsea',style: TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      children: [
                        const Text('VS', style: TextStyle(fontWeight: FontWeight.bold),),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                            decoration: drawDecoration,
                            child: TextButton(onPressed: () {}, child:Text('Draw', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),))),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset('assets/chelsea.png'),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('man u', style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
