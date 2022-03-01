import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wood_cafe/screen/auth/requestsent.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sign In',
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Color(0xff000000),
                  letterSpacing: .5),
            )),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Forgot password',
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff000000),
                        letterSpacing: .5),
                  )),
              SizedBox(
                height: 10,
              ),
              RichText(
                // textAlign: TextAlign.start,
                text: TextSpan(children: <InlineSpan>[
                  TextSpan(
                      text:
                          'Enter your email address and we will send you a reset instructions.',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff000000),
                            letterSpacing: .5),
                      )),
                  // TextSpan(
                  //     recognizer: TapGestureRecognizer()
                  //       ..onTap = () {
                  //         print('Terms and Conditions Single Tap');
                  //       },
                  //     text: 'Create new account',
                  //     style: GoogleFonts.roboto(
                  //       textStyle: const TextStyle(
                  //           fontSize: 16,
                  //           fontWeight: FontWeight.w400,
                  //           color: Colors.red,
                  //           letterSpacing: .5),
                  //     )
                  // )
                ]),
              ),
              SizedBox(
                height: 50,
              ),
              TextField(
                // obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          BorderSide(color: Color(0xffFBFBFB), width: 2)),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // TextField(
              //   obscureText: _isObscure,
              //   decoration: InputDecoration(
              //       labelText: 'Password',
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(5),
              //           borderSide: BorderSide(color: Color(0xffFBFBFB), width: 2)),
              //       suffixIcon: IconButton(
              //           icon: Icon(
              //               _isObscure ? Icons.visibility : Icons.visibility_off),
              //           onPressed: () {
              //             setState(() {
              //               _isObscure = !_isObscure;
              //             });
              //           })),
              // ),

              SizedBox(
                height: 20,
              ),
              // Text(
              //     'Forget Password?', textAlign: TextAlign.center,
              //
              //     style: GoogleFonts.roboto(
              //       textStyle: const TextStyle(
              //
              //           fontSize: 12,
              //           fontWeight: FontWeight.w400,
              //           color: Color(0xff000000),
              //           letterSpacing: .5),
              //     )),
              // SizedBox(height: 10,),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: TextButton.styleFrom(
                        primary: Colors.red,
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'RESET PASSWORD',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ResetEmailSent()),
                        );
                      }
                      // if (controller.errors.isEmpty) {
                      //   controller.register({
                      //     "firstName": controller
                      //         .firstNameTextEditingController.text,
                      //     "lastName": controller
                      //         .lastNameTextEditingController.text,
                      //     "state": 'Anambra',
                      //     "country": "Nigeria",
                      //     "phoneNumber": controller
                      //         .numberTextEditingController.text,
                      //     "roles": 1,
                      //     "currencyType": 1,
                      //     'emailAddress': controller
                      //         .emailTextEditingController.text,
                      //     'password': controller
                      //         .passwordTextEditingController.text
                      //   });
                      // Get.to(() => UserinfoView());

                      )),
            ],
          ),
        ),
      ),
    );
  }
}
