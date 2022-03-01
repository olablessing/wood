import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wood_cafe/routes.dart';
import 'package:wood_cafe/screen/checkout/payment.dart';
import 'package:wood_cafe/theme.dart';
import 'ContentModel.dart';
import 'home.dart';
import 'onboarding.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        contents[i].image,
                        height: 367,
                        width: 307,
                      ),
                      Center(
                        child: Text(
                          contents[i].title,
                          style: TextStyle(
                            fontSize:30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 1),
                      Text(
                        contents[i].discription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                contents.length,
                (index) => buildDot(index, context),
              ),
            ),
          ),
          Container(
            height: 48,
            width: 335,
            margin: EdgeInsets.all(40),
            child: FlatButton(
              child: Text(currentIndex == contents.length - 1
                  ? "GET STARTED"
                  : "GET STARTED",style:TextStyle(fontWeight: FontWeight.bold,fontSize:16)),
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  Navigator.of(context).pushReplacementNamed(PageRoutes.signUp);
                }
                _controller.nextPage(
                  duration: Duration(milliseconds: 100),
                  curve: Curves.bounceIn,
                );
              },
              color: Colors.redAccent,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 5,
      width: currentIndex == index ? 7 : 5,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentIndex == index ? Colors.greenAccent : grey),
    );
  }
}
