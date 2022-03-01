import 'package:flutter/material.dart';
// import 'package:wood_cafe/theme.dart';
// import '../theme.dart';

class SignUpViewThree extends StatelessWidget {
  const SignUpViewThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WoodCafe',
        // theme: new ThemeData(),
        home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('SignUp to Wood Cafe'),
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            leading:
                const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
          ),
          body: ListView(children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.center,
              child: Column(children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Center(
                          child: Text('Verify phone number',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold))),
                      SizedBox(height: 15),
                      Center(
                          child: Text(
                        'Enter the 4-Digit code code sent to you at',
                        style: TextStyle(
                          color: Color(0xFF757575),
                        ),
                      )),
                      Center(
                          child: Text(
                        '+2348066455555',
                        style: TextStyle(
                          color: Color(0xFF757575),
                        ),
                      )),
                      SignUpForm()
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
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
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
          )
        ],
      ),
    );
  }
}
