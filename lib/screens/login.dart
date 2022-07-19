import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:runam/screens/nav_selector.dart';
import 'package:runam/screens/password_reset.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:runam/screens/register.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import '../constants/color_const.dart';
import '../models/custom_buttons.dart';
import '../widgets/custom_formfield.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
FirebaseAuth _auth = FirebaseAuth.instance;

String password = '';
String email = '';



bool _obscureText = false;
@override
void initState() {
  _obscureText = true;
}

late FToast fToast;

class _LoginState extends State<Login> {

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _obscureText = true;
  }


  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Login',
          style: TextStyle(
              color: primaryColor, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Colors.white,
      body: BlurryModalProgressHUD(
        inAsyncCall: isLoading,
        blurEffectIntensity: 2,
        dismissible: false,
        progressIndicator:  CircularProgressIndicator(
          color: primaryColor,
        ),
        opacity: 0.4,
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 37,
                  ),

                  /// email form field.
                  CustomFormField(
                    keyBoardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'field required';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    hintText: 'Enter your email',
                    labelText: 'Email',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2.0),
                      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    ),
                    obscureText: false,
                  ),
                  const SizedBox(
                    height: 37,
                  ),

                  /// password form field.
                  CustomFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    obscureText: _obscureText,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'field required';
                      }

                      if (value.length < 6) {
                        return 'password must be 6 characters and above';
                      }
                      return null;
                    },

                    /// password obscure text.
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: primaryColor,
                      ),
                    ),
                    hintText: 'Select a secure password',
                    labelText: 'Password',
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2.0),
                      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  /// where to reset password from login page.
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ResetPassword()));
                      },
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: primaryColor),
                      )),
                  const SizedBox(
                    height: 20,
                  ),

                  /// Button to login in the app from login
                  CustomButton(
                      borderRadius: (20),
                      buttonText: ('Login'),
                      textColor: Colors.white,
                      buttonColor: primaryColor,
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });

                          try {
                             await _auth
                                .signInWithEmailAndPassword(
                                    email: email, password: password.toString())
                                .then((user) => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>  const NavSelector()),
                                    (route) => false));

                            setState(() {
                              isLoading = false;
                            });
                          } on FirebaseAuthException catch (error) {
                            fToast.showToast(
                              toastDuration: const Duration(seconds: 4),
                              child: Material(
                                color: Colors.white,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.face),
                                    Text(
                                      error.message.toString(),
                                      style: const TextStyle(
                                          color: Colors.black87, fontSize: 16.0),
                                    )
                                  ],
                                ),
                              ),
                              gravity: ToastGravity.TOP,
                            );
                            setState(() {
                              isLoading = false;
                            });
                          }
                        }
                      }),
                  const SizedBox(
                    height: 40,
                  ),

                  /// Button to migrate to register screen if one doesn't have an account in the app from login screen
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t Have an account ?'),
                      const SizedBox(
                        width: 5,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Register()),
                                (route) => false);
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: primaryColor),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
