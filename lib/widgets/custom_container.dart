import 'package:flutter/material.dart';


class CustomContainer extends StatelessWidget {
  CustomContainer({Key? key,

  required this.containerChild,
     required this.padding
  }) : super(key: key);


  final Widget containerChild;
  EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      padding: padding,
      decoration:  BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 20,
            offset: const Offset(0, 5), // shadow direction: bottom right
          )
        ],
      ),
      child: containerChild,
    );
  }
}


