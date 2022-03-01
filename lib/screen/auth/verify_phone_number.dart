import 'package:flutter/material.dart';
import 'package:wood_cafe/routes.dart';

import 'otp.dart';

class VerifyPhoneNumber extends StatefulWidget {
  const VerifyPhoneNumber({Key? key}) : super(key: key);

  @override
  _VerifyPhoneNumberState createState() => _VerifyPhoneNumberState();
}

class _VerifyPhoneNumberState extends State<VerifyPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Login to Wood Café',
            style: TextStyle(color: Colors.black87, fontSize: 14),
          ),
          leading: IconButton(
            color: Colors.black.withOpacity(0.7),
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).maybePop();
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Center(
                child: Container(
                    child: Text('Get started with wood Cafe',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ))),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Enter your phone number to use foodly and enjoy your food',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black38,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 28,
              ),
              Container(
                padding: EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PHONE NUMBER',
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                        prefix: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            '(+234)',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(PageRoutes.otpPage);
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
