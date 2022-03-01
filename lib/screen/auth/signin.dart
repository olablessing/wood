import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wood_cafe/models/models.dart';
import 'package:wood_cafe/network.dart';
import 'package:wood_cafe/routes.dart';
import 'package:wood_cafe/tools.dart' as tools;

class Login extends StatefulWidget {
  const Login({Key? key, required String title}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

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
                  color: Color.fromARGB(255, 54, 54, 54),
                  letterSpacing: .5),
            )),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Welcome to Wood Café',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff000000),
                          letterSpacing: .5),
                    )),
                const SizedBox(height: 18),
                RichText(
                  // textAlign: TextAlign.start,
                  text: TextSpan(children: <InlineSpan>[
                    TextSpan(
                        text:
                            'Enter your Phone number or Email for sign in, Or ',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF757575),
                              letterSpacing: .5),
                        )),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamed(PageRoutes.signUp);
                          },
                        text: 'create new account',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              letterSpacing: .5),
                        ))
                  ]),
                ),
                const SizedBox(height: 50),
                TextFormField(
                  validator: tools.Validators.validateEmail,
                  onChanged: (v) => _email = v.trim(),
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            color: Color(0xffFBFBFB), width: 2)),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onChanged: (v) => _password = v,
                  validator: tools.Validators.isNotEmpty,
                  obscureText: _isObscure,
                  onFieldSubmitted: (v) {
                    _signIn();
                  },
                  decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                              color: Color(0xffFBFBFB), width: 2)),
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          })),
                ),
                const SizedBox(height: 58),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(PageRoutes.resetPassword);
                  },
                  child: Text('Forget Password?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 57, 57, 57),
                            letterSpacing: .5),
                      )),
                ),
                const SizedBox(height: 18),
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        primary: Colors.red,
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: _signIn,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() {
    if (_formKey.currentState!.validate()) {
      HttpRequest(
        'user/signin',
        body: {"email": _email, "password": _password},
        onSuccess: (resp, result) {
          print(resp.statusCode);
          Provider.of<GlobalState>(context, listen: false)
              .setData(result['data']);
          Navigator.of(context).pushReplacementNamed(PageRoutes.home);
        },
        context: context,
        loader: LoaderType.popup,
      ).send();
    }
  }
}
