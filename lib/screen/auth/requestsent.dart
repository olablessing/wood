import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wood_cafe/screen/Homepage/home.dart';
import 'package:wood_cafe/screen/menu/menu_detail.dart';

class ResetEmailSent extends StatefulWidget {
  const ResetEmailSent({Key? key}) : super(key: key);

  @override
  _ResetEmailSentState createState() => _ResetEmailSentState();
}

class _ResetEmailSentState extends State<ResetEmailSent> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Forgot Password',
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
              Text('Reset email sent',
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
                          'We have sent a instructions email to Nawfazim@icloud.com.',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff000000),
                            letterSpacing: .5),
                      )),
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('Having a problem?');
                        },
                      text: 'Create new account',
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.red,
                            letterSpacing: .5),
                      ))
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: TextButton.styleFrom(
                        primary: Colors.red,
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'SEND AGAIN',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
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
