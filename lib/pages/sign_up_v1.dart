import 'package:flutter/material.dart';
// import 'package:wood_cafe/theme.dart';
// import '../theme.dart';

class SignUpViewOne extends StatelessWidget {
  const SignUpViewOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WoodCafe',
        // theme: new ThemeData(),
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading:
                const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
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
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                      child: Text('Create Account',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold))),
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
                    children: <Widget>[
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            'for sign up.',
                            style: TextStyle(
                              color: Color(0xFF757575),
                            ),
                          )),
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text('Already have account?',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12)))
                    ],
                  ),
                  const SignUpForm(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const <Widget>[
                      Center(
                          child: Text(
                        'By Signing up you agree to our Terms and',
                        style: TextStyle(
                          color: Color(0xFF757575),
                        ),
                      )),
                      Center(
                          child: Text(
                        'Conditions & Privacy Policy',
                        style: TextStyle(
                          color: Color(0xFF757575),
                        ),
                      )),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.0, horizontal: 60.0),
                          child: Text(
                            "Or",
                            style: TextStyle(
                              color: Color(0xFF757575),
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       vertical: 5.0, horizontal: 5.0),
                  //   child:
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.facebook_outlined,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      label: const Text(
                        'CONNECT WITH FACEBOOK',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(400, 50),
                        primary: Color.fromARGB(255, 12, 71, 119),
                      ),
                    ),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     fixedSize: const Size(400, 50),
                    //     primary: Color.fromARGB(255, 12, 71, 119),
                    //   ),
                    //   onPressed: () {},
                    //   child: const Text(
                    //     'CONNECT WITH FACEBOOK',
                    //     style: TextStyle(fontSize: 15),
                    //   ),
                    // ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       vertical: 5.0, horizontal: 5.0),
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       fixedSize: const Size(400, 50),
                  //       primary: Colors.blue,
                  //     ),
                  //     onPressed: () {},
                  //     child: const Text(
                  //       'CONNECT WITH GOOGLE',
                  //       style: TextStyle(fontSize: 15),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  // SignInButton(
                  //   Buttons.Google,
                  //   text: Text(
                  //     'CONNECT WITH GOOGLE',
                  //     style: TextStyle(fontSize: 15),
                  //   ),
                  //   onPressed: () {},
                  // ),
                  Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.facebook_outlined,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      label: const Text(
                        'CONNECT WITH GOOGLE',
                        style: TextStyle(fontSize: 15),
                      ),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(400, 50),
                        primary: Colors.blue,
                      ),
                    ),
                  ),
                ])
              ]),
            ),
          ]),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {},
        ));
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;
  // bool _showConfirmPassword = false;

  // final _textFieldState = InputDecoration(border: , fillColor: Colors.white, filled: true, )

  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
  //  void _togglevisibility() {
  //   setState(() {
  //     _showConfirmPassword = !_showConfirmPassword;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              child: TextFormField(
                // The validator receives the text that the user has entered.
                style: const TextStyle(fontSize: 12),
                // textInputAction: _textFieldState,
                keyboardType: TextInputType.name,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  labelText: 'FULL NAME',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 90, 85, 85)),
                  suffixIcon: Icon(Icons.check),
                  fillColor: Color(0xFFF5F5F5),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  // border: OutlineInputBorder(gapPadding: 0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your fullname';
                  }
                  return null;
                },
              )),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
              child: TextFormField(
                // The validator receives the text that the user has entered.
                style: const TextStyle(fontSize: 12),
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  labelText: 'EMAIL ADDRESS',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 90, 85, 85)),
                  suffixIcon: Icon(Icons.check),
                  fillColor: Color(0xFFF5F5F5),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  // border: OutlineInputBorder(
                  //   gapPadding: 0,
                  // ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              )),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
              child: TextFormField(
                // The validator receives the text that the user has entered.
                style: const TextStyle(fontSize: 12),
                controller: null,
                obscureText: !_showPassword,
                cursorColor: Colors.black,
                // expands: true,
                decoration: InputDecoration(
                  labelText: 'PASSWORD',
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 90, 85, 85)),
                  fillColor: const Color(0xFFF5F5F5),
                  filled: true,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  // labelText: "PASSWORD",
                  // labelStyle: TextStyle(color: Colors.grey),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _togglevisibility();
                    },
                    child: Icon(
                      _showPassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                ),

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
              )),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
              child: TextFormField(
                // The validator receives the text that the user has entered.
                style: const TextStyle(fontSize: 12),
                keyboardType: TextInputType.phone,
                obscureText: true,
                cursorColor: Colors.black,
                // expands: true,
                decoration: const InputDecoration(
                  labelText: 'CONFIRM PASSWORD',
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 90, 85, 85)),
                  fillColor: Color(0xFFF5F5F5),
                  filled: true,
                  // labelText: "PASSWORD",
                  // labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
              )),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(400, 50),
                primary: Colors.red,
              ),
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text(
                'SIGN UP',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
