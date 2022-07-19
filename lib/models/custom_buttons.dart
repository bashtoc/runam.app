import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key,
    this.buttonColor,
    required this.textColor,
    this.borderRadius,
    this.buttonText,
    required this.onTap,


  }) : super(key: key);

  final VoidCallback onTap;
  final Color? buttonColor;
  final double? borderRadius;
  final Color textColor;
  final String? buttonText;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(color: buttonColor?? Colors.white,borderRadius: BorderRadius.circular(borderRadius?? 0) ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                buttonText?? 'add button Text', style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
