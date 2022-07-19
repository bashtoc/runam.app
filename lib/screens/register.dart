import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:runam/database/user_management.dart';
import 'package:runam/models/bottom_navbar.dart';

import '../constants/color_const.dart';
import '../models/custom_buttons.dart';
import '../widgets/custom_formfield.dart';
import 'dashboard.dart';
import 'login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

bool showErrorMessage = false;
bool _obscureText = true;

late FToast fToast;

class _RegisterState extends State<Register> {
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _obscureText = false;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool checkIndex = false;
  bool rememberMe = false;
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Register',
          style: TextStyle(
              color: primaryColor, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Colors.white,
      body: BlurryModalProgressHUD(
        inAsyncCall: isLoading,
        blurEffectIntensity: 2,
        dismissible: false,
        progressIndicator: CircularProgressIndicator(
          color: primaryColor,
        ),
        opacity: 0.4,
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),

                  /// this is the form field for email
                  CustomFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'field required';
                      }
                      return null;
                    },
                    keyBoardType: TextInputType.emailAddress,
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
                  Row(
                    children: [
                      SizedBox(
                        width: 170,
                        child: CustomFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'field required';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            firstName = value;
                          },
                          hintText: 'First Name',
                          labelText: 'First',
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff423B9A), width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          obscureText: false,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 170,
                        child: CustomFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'field required';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            lastName = value;
                          },
                          hintText: 'Last Name',
                          labelText: 'Last',
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff423B9A), width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          ),
                          obscureText: false,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 37,
                  ),

                  CustomFormField(
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
                    onChanged: (value) {
                      password = value;
                    },
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
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
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Have an account ?'),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                                (route) => false);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: primaryColor),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),

                  ///this is the button for register page
                  CustomButton(
                      borderRadius: (20),
                      buttonText: ('Register'),
                      textColor: Colors.white,
                      buttonColor: primaryColor,
                      onTap: () async {
                        if (checkIndex != true) {
                          setState(() => showErrorMessage = true);
                        } else {
                          if (_formKey.currentState!.validate()
                              ) {
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              await _auth.createUserWithEmailAndPassword(
                                      email: email, password: password.toString());
                              DbHelper().add(firstName: firstName, lastName: lastName);
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavBar()), (route) => false);

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
                                            color: Colors.black87,
                                            fontSize: 16.0),
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
                        }
                      }),
                  showErrorMessage
                      ? Container(
                          decoration: BoxDecoration(
                              // color: Colors.red,
                              borderRadius: BorderRadius.circular(80.0)),
                          child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Accept the terms and conditions to proceed..',
                                style: TextStyle(color: Colors.red),
                              )))
                      : Container(),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              activeColor: primaryColor,
                              value: checkIndex,
                              onChanged: (value) {
                                setState(() {
                                  checkIndex = value!;
                                });
                                if (checkIndex == true) {
                                  setState(() => showErrorMessage = false);
                                }
                              }),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Terms and Conditions',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
