import 'package:flutter/material.dart';
import 'package:wood_cafe/models/orders.dart';
import 'package:wood_cafe/screen/checkout/paymentWidget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Payment extends StatefulWidget {
  final OrderModel order;
  const Payment({Key? key, required this.order}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  child: Stack(alignment: Alignment.center, children: <Widget>[
                Image.asset(
                  'assets/images/Banner.png',
                  height: 235,
                  width: 375,
                ),
                Image.asset(
                  'assets/images/image3.png',
                  height: 185,
                  width: 335,
                ),
                SvgPicture.asset('assets/svg/How will you like to pay_.svg')
              ])),
              MyStatefulWidget(
                key: null,
              )
            ],
          ),
        ),
      ),
    );
  }
}
