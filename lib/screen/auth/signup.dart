import 'package:flutter/material.dart';

import 'otp.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({Key? key}) : super(key: key);

  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          
           
            child: Column(
              children: [
                Row(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          size: 20,
                          color: Colors.black54,
                        ),
                      ),
                    ),


                    Align(
                      alignment: Alignment.center,
                      child: Text('Login to Wood Cafe',
                      style:TextStyle(fontSize:10,
                      fontWeight:FontWeight.bold,
                      
                      )
                      )
                    ),
                  ],
                ),
                SizedBox(
                  height: 18,
                ),
                Center(
                  child: Container(
                    
                   
                    child: Text('Get started with wood Cafe',
                    style:TextStyle(
                      fontWeight:FontWeight.bold,
                      fontSize:16,
                    )
                    )
                  ),
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
                      style:TextStyle(
                        color:Colors.grey,
                      )
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: 15,
                          
                        ),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12), ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12), ),
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
                      SizedBox(
                        height: 22,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => OTPPage()),
                            );
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
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(fontSize: 16),
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