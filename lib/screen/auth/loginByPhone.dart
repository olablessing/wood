import 'package:flutter/material.dart';

class LoginWithPhone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 375,
              child: Row(
                children: const [
                  Icon(Icons.shop),
                  Center(
                    child: Text('Login to Wood Cafe',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            ),
            Container(
              height: 42,
              width: 239,
              child: Center(
                child: Text(
                  '''Get started with Wood Cafe''',
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    color: Colors.black,

                    /* letterSpacing: -0.4000000059604645, */
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
                height: 35,
                width: 263,
                child: Column(
                  children: const [
                    Center(
                      child: Text(
                          'Enter your phone number to use foodly and       enjoy your food ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          )),
                    ),
                    SizedBox(height: 2),
                  ],
                )),
            SizedBox(height: 30),
            TextFormField(
              // The validator receives the text that the user has entered.
              style: const TextStyle(fontSize: 12),
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                fillColor: Color(0xFFF5F5F5),
                filled: true,
                border: OutlineInputBorder(gapPadding: 0),
                hintText: "Full Name",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your fullname';
                }
                return null;
              },
            ),
            SizedBox(height: 14),
            TextFormField(
              // The validator receives the text that the user has entered.
              style: const TextStyle(fontSize: 12),
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                fillColor: Color(0xFFF5F5F5),
                filled: true,
                border: OutlineInputBorder(gapPadding: 0),
                hintText: "Email Address",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your fullname';
                }
                return null;
              },
            ),
            SizedBox(height: 14),
            TextFormField(
              // The validator receives the text that the user has entered.
              style: const TextStyle(fontSize: 12),
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                fillColor: Color(0xFFF5F5F5),
                filled: true,
                border: OutlineInputBorder(gapPadding: 0),
                hintText: "Password",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your fullname';
                }
                return null;
              },
            ),
            SizedBox(height: 24),
            Container(
                height: 48,
                width: 335,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text('SIGN UP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      )),
                )),
            SizedBox(
              height: 24,
            ),
            Center(
              child: Container(
                  height: 36,
                  width: 204,
                  child: Center(
                    child: Text(
                        'By Signing up agree to our Terms Conditions & Privacy Policy',
                        style: TextStyle(
                          fontSize: 10,
                        )),
                  )),
            ),
            Center(child: Text('Or', style: TextStyle(fontSize: 10))),
            SizedBox(
              height: 24,
            ),
            Container(
                height: 48,
                width: 335,
                decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text('CONNECT WITH FACEBOOK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      )),
                )),
            SizedBox(height: 16),
            Container(
                height: 48,
                width: 335,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text('CONNECT WITH GOOGLE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      )),
                )),
          ],
        ),
      ),
    );
  }
}
