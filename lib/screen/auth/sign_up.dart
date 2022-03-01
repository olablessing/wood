import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:wood_cafe/network.dart';
import 'package:wood_cafe/routes.dart';
import 'package:wood_cafe/screen/auth/signin.dart';
import 'package:wood_cafe/widgets/passwordField.dart';
import 'package:wood_cafe/tools.dart' as tools;
// import '../theme.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late String _firstName = '';
  late String _lastName = '';
  late String _password = '';
  late String _email = '';
  late String _phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WoodCafe',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Sign Up to Wood Cafe',
              style: TextStyle(color: Color.fromARGB(255, 56, 55, 55))),
          leading: IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              icon: const Icon(Icons.arrow_back_ios_rounded,
                  color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                    child: Text('Create Account',
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold))),
                const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                    child: Text(
                      'Enter your Name, Email and Password',
                      style: TextStyle(
                        color: Color(0xFF757575),
                      ),
                    )),
                Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          'for sign up.',
                          style: TextStyle(
                            color: Color(0xFF757575),
                          ),
                        )),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Login(title: 'Login')),
                          );
                        },
                        child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: Text('Already have account?',
                                style: TextStyle(
                                    color: Colors.red, fontSize: 12))))
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
                          child: TextFormField(
                            style: const TextStyle(fontSize: 12),
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              fillColor: Color(0xFFF5F5F5),
                              filled: true,
                              border: OutlineInputBorder(gapPadding: 0),
                              labelText: "First Name",
                            ),
                            validator: tools.Validators.validateName,
                            onSaved: (v) {
                              _firstName = v!;
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
                          child: TextFormField(
                            style: const TextStyle(fontSize: 12),
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              fillColor: Color(0xFFF5F5F5),
                              filled: true,
                              border: OutlineInputBorder(gapPadding: 0),
                              labelText: "Last Name",
                            ),
                            validator: tools.Validators.validateName,
                            onSaved: (v) {
                              _lastName = v!;
                            },
                          )),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
                          child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(fontSize: 12),
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                fillColor: Color(0xFFF5F5F5),
                                filled: true,
                                border: OutlineInputBorder(
                                    gapPadding: 0,
                                    borderSide: BorderSide(color: Colors.teal)),
                                labelText: "Email Address",
                              ),
                              validator: tools.Validators.validateEmail,
                              onChanged: (value) {
                                _email = value;
                              })),
                      // Padding(
                      //     padding: const EdgeInsets.symmetric(
                      //         vertical: 10.0, horizontal: 5.0),
                      //     child: TextFormField(
                      //         keyboardType: TextInputType.phone,
                      //         style: const TextStyle(fontSize: 12),
                      //         cursorColor: Colors.black,
                      //         decoration: const InputDecoration(
                      //           fillColor: Color(0xFFF5F5F5),
                      //           filled: true,
                      //           border: OutlineInputBorder(
                      //               gapPadding: 0,
                      //               borderSide: BorderSide(color: Colors.teal)),
                      //           labelText: "Phone Number",
                      //         ),
                      //         validator: tools.Validators.isNotEmpty,
                      //         onChanged: (value) {
                      //           _phoneNumber = value;
                      //         })),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        child: PasswordField(
                          fillColor: Color(0xFFF5F5F5),
                          filled: true,
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.grey),
                          borderDecoration: OutlineInputBorder(gapPadding: 0),
                          hintText: "Password",
                          validator: tools.Validators.isNotEmpty,
                          onChanged: (value) {
                            _password = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        child: PasswordField(
                          fillColor: Color(0xFFF5F5F5),
                          filled: true,
                          validator: (v) {
                            return (_password == v)
                                ? tools.Validators.isNotEmpty(v)
                                : 'Password do not match';
                          },
                          onFieldSubmitted: (_) {
                            _signUp();
                          },
                          labelText: "Re-enter Password",
                          labelStyle: TextStyle(color: Colors.grey),
                          borderDecoration: OutlineInputBorder(gapPadding: 0),
                          hintText: "Re-enter Password",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 5.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize:
                                  Size(MediaQuery.of(context).size.width, 44),
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: _signUp,
                          child: const Text(
                            'SIGN UP',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        const TextSpan(
                          text: 'By Signing up you agree to our ',
                          style: TextStyle(
                            color: Color(0xFF757575),
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context)
                                    .pushNamed(PageRoutes.signIn);
                              },
                            text: 'Terms and Conditions & Privacy Policy?',
                            style: TextStyle(color: Colors.red, fontSize: 12)),
                      ])),
                ),
                const SizedBox(height: 12),
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       vertical: 20.0, horizontal: 5.0),
                //   child: ElevatedButton.icon(
                //     icon: const Icon(MdiIcons.facebook),
                //     style: ElevatedButton.styleFrom(
                //         fixedSize: Size(MediaQuery.of(context).size.width, 44),
                //         primary: const Color(0xff395998),
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(12))),
                //     onPressed: () {
                //       Navigator.of(context)
                //           .pushNamed(PageRoutes.verifyPhoneNumber);
                //     },
                //     label: const Text(
                //       'CONNECT WITH FACEBOOK',
                //       style: TextStyle(fontSize: 13),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 5.0),
                //   child: ElevatedButton.icon(
                //     icon: const Icon(MdiIcons.google),
                //     style: ElevatedButton.styleFrom(
                //         fixedSize: Size(MediaQuery.of(context).size.width, 44),
                //         primary: const Color(0xff4285F4),
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(12))),
                //     onPressed: () {},
                //     label: const Text(
                //       'CONNECT WITH GOOGLE',
                //       style: TextStyle(fontSize: 13),
                //     ),
                //   ),
                // ),
              ],
            )
          ]),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.thumb_up),
      //   onPressed: () => {},
      // ),
    );
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      HttpRequest(
        'user/signup',
        body: {
          "firstName": _firstName,
          "lastName": _lastName,
          // "phone": _phoneNumber,
          "email": _email.trim(),
          "password": _password,
        },
        context: context,
        loader: LoaderType.popup,
        onSuccess: (_, result) {
          Navigator.of(context).pushReplacementNamed(PageRoutes.home);
        },
      ).send();
    }
  }
}
