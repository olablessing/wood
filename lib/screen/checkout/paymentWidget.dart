import 'package:flutter/material.dart';
import 'package:wood_cafe/screen/Homepage/home.dart';
import 'package:wood_cafe/screen/Homepage/onboarding.dart';
import 'package:wood_cafe/screen/checkout/checkin.dart';
import 'package:wood_cafe/tools.dart';





enum Payment { payOnPickup, PaywithCard, CashOnDelivery }  
  
class MyStatefulWidget extends StatefulWidget {  
  MyStatefulWidget({Key? key}) : super(key: key);  
  
  @override  
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();  
}  
  
class _MyStatefulWidgetState extends State<MyStatefulWidget> { 
  var _paymentMethod = Payment.CashOnDelivery; 
  
  
  Widget build(BuildContext context) {  
    return Column(  
      children: <Widget>[  
         RadioListTile<Payment>(
            dense: true,
            value: Payment.payOnPickup,
            groupValue: _paymentMethod,
            onChanged: (v) {
              setState(() {
                
                checkout(context, 'success', onComplete: (() => Onbording() ));
                
              });
            },
            title: Text('Pay On Pickup ', 
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize:16,
            )
            
            )),
        RadioListTile<Payment>(
            dense: true,
            value: Payment.PaywithCard,
            groupValue: _paymentMethod,
            onChanged: (v) {
              setState(() {
               _paymentMethod = v!;
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  PaymentPage()),
              );
              });
            },
            title:Text('Pay with Card',
             style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize:16,
            )
            )),


        RadioListTile<Payment>(
            dense: true,
            value: Payment.CashOnDelivery,
            groupValue: _paymentMethod,
            onChanged: (v) {
              setState(() {
               
              checkout(context, 'success', onComplete: (() => Onbording() ));


              });
            },
            title:Text('Cash On Delivery ',
             style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize:16,
            )
            )),    
 
      ],  
    );  
  }  
}  