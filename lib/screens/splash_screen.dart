import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:runam/screens/register.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'nav_selector.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);



  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 3), () {
      if (user == null) {

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) =>  const Register()),
                (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const NavSelector()),
                (route) => false);
      }
    });
    return Scaffold(
      body:  Center(
          child: SvgPicture.asset('assets/runamlogo.svg')
    ));
  }
}
