import 'package:flutter/material.dart';

import '../constants/color_const.dart';

class Activities extends StatelessWidget {
  const Activities({Key? key}) : super(key: key);

  final TextStyle styler = const TextStyle(fontWeight: FontWeight.bold,color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Activities',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
              color: primaryColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 20,
                  offset: const Offset(0, 5), // shadow direction: bottom right
                )
              ],
            ),
            margin: const EdgeInsets.only(left: 20, right: 20),
            height: 100,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Predict',
                      style: styler,
                    ),
                     Text(
                      'chelsea', style: styler,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Stake',
                      style: styler,
                    ),
                     Text(
                      '\$400', style: styler,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Status',
                      style: styler,
                    ),
                    const Text(
                      'pending',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
