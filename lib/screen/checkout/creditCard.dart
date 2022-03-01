import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:badges/badges.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wood_cafe/screen/checkout/paymentWidget.dart';

class CardPayment extends StatefulWidget {
  @override
  _CardPaymentState createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text('Make Payment'),

                Container(
                  
                  child: Stack(
                    children: <Widget>[
                     Center(
                       child: Container(

                         margin: EdgeInsets.only(left:0, top:65.0,right:0,bottom:0),
                         child: SvgPicture.asset('assets/svg/Rectangle 1319.svg',height:138,width:273)),
                     ),
                      Center(child: SvgPicture.asset('assets/svg/Rectangle 1318.svg',height:195,width:320)),
                      Center(child: SvgPicture.asset('assets/svg/Frame 5629.svg',height:170,width:320))
                    ],
                  ),
                ),
               
                Container(
                  height:223,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text('Card Number'),
                          
                        ],
                      ),
                    ],
                  ),
                )


                

                


         
              ],
            ),
          ),
        ),
      ),
    );
  }
}

