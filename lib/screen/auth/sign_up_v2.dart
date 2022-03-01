import 'package:flutter/material.dart';
import 'package:wood_cafe/routes.dart';
// import 'package:wood_cafe/theme.dart';
// import '../theme.dart';

class SignUpViewTwo extends StatefulWidget {
  const SignUpViewTwo({Key? key}) : super(key: key);

  @override
  State<SignUpViewTwo> createState() => _SignUpViewTwoState();
}

class _SignUpViewTwoState extends State<SignUpViewTwo> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WoodCafe',
        // theme: new ThemeData(),
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon:
                  const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            backgroundColor: Colors.white,
            title: const Text('SignUp to Wood Cafe'),
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            elevation: 0,
            centerTitle: true,
          ),
          body: ListView(children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.center,
              child: Column(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Center(
                      child: Text('Get Started with Wood Café',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  SizedBox(height: 15),
                  Center(
                      child: Text(
                    '''Enter your phone number to use foodly and
                    enjoy your food :)''',
                    style: TextStyle(
                      color: Color(0xFF757575),
                    ),
                  )),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 30),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 5.0),
                            child: TextFormField(
                              // The validator receives the text that the user has entered.
                              style: const TextStyle(fontSize: 12),
                              // textInputAction: _textFieldState,
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.black,
                              decoration: const InputDecoration(
                                labelText: 'PHONE NUMBER',
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 90, 85, 85)),
                                prefixIcon: Icon(Icons.school),
                                prefixText: '+234  ',
                                fillColor: Color(0xFFF5F5F5),
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                                // border: OutlineInputBorder(gapPadding: 0),
                                hintText: "8066455555",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a valid phone number';
                                }
                                return null;
                              },
                            )),
                        const SizedBox(height: 300),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 5.0),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(400, 50),
                              primary: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(PageRoutes.otpPage);
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')),
                                );
                              }
                            },
                            child: const Text(
                              'SIGN UP',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ])
              ]),
            ),
          ]),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {},
        ));
  }
}
