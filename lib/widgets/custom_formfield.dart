import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
   const CustomFormField({
    Key? key,
     this.textColor,
    this.borderRadius,
    this.hintText,
    this.labelText,
    this.onChanged,
    this.validator,
    this.outlineInputDecorator,
     this.focusedBorder,
     this.suffixIcon, required this.obscureText,
     this.keyBoardType,

  }) : super(key: key);

  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final double? borderRadius;
  final Color? textColor;
  final String? hintText;
  final String? labelText;
  final dynamic outlineInputDecorator;
  final dynamic focusedBorder;
  final Widget? suffixIcon;
   final bool obscureText;
   final TextInputType? keyBoardType;
  @override
  Widget build(BuildContext context) {
    return
     TextFormField(
              keyboardType: keyBoardType,
          obscureText: obscureText ,
        validator: validator,
          textAlign: TextAlign.center,
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelStyle: const TextStyle(fontSize: 14, color:Colors.black),
          border: outlineInputDecorator,
          enabledBorder:  const OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          focusedBorder: focusedBorder??  const OutlineInputBorder(
            borderSide:
            BorderSide(color: Color(0xff423B9A), width: 2.0),
          ),
          hintText: hintText,
          labelText: labelText,
        ),
      );

  }
}
