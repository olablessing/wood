import 'package:flutter/material.dart';
import 'package:wood_cafe/models/orders.dart';
import 'package:wood_cafe/screen/Homepage/home.dart';
import 'package:wood_cafe/screen/Homepage/onboarding.dart';
import 'package:wood_cafe/screen/auth/requestsent.dart';
import 'package:wood_cafe/screen/auth/resetpassword.dart';
import 'package:wood_cafe/screen/auth/sign_up_v2.dart';

import 'package:wood_cafe/screen/auth/signin.dart';
import 'package:wood_cafe/screen/auth/otp.dart';
import 'package:wood_cafe/screen/auth/sign_up.dart';
import 'package:wood_cafe/screen/checkout/payment.dart';
import 'package:wood_cafe/screen/order/cart_page.dart';
import 'package:wood_cafe/screen/menu/menu_detail.dart';
import 'package:wood_cafe/screen/order/order_list.dart';

// Pages

class PageRoutes {
  static const String onboarding = 'onboarding';
  static const String home = 'home';

  // auth
  static const String signUp = 'signup';
  static const String signIn = 'signIn';
  static const String otpPage = 'otp';
  static const String verifyPhoneNumber = 'signup/verify_number';
  static const String resetPassword = 'reset_password';
  static const String resetEmail = 'reset_email';

  static const String cartPage = 'cart';
  static const String orderPage = 'order_page';
  static const String payment = 'payment';
}

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  WidgetBuilder builder;

  switch (settings.name) {
    case '/':
      builder = (ctx) => const HomePage();
      break;
    case PageRoutes.home:
      builder = (ctx) => const HomePage();
      break;
    case PageRoutes.onboarding:
      builder = (ctx) => Onbording();
      break;
    case PageRoutes.signUp:
      builder = (ctx) => const SignUp();
      break;
    case PageRoutes.signIn:
      builder = (ctx) => const Login(title: 'login');
      break;
    case PageRoutes.otpPage:
      builder = (ctx) => const OTPPage();
      break;
    case PageRoutes.verifyPhoneNumber:
      builder = (ctx) => const SignUpViewTwo();
      break;
    case PageRoutes.cartPage:
      builder = (ctx) => const CartPage();
      break;
    case PageRoutes.orderPage:
      builder = (ctx) => const OrderList();
      break;
    case PageRoutes.payment:
      builder = (ctx) => Payment(order: settings.arguments as OrderModel);
      break;

    case PageRoutes.resetPassword:
      builder = (ctx) => const ResetPassword();
      break;
    case PageRoutes.resetEmail:
      builder = (ctx) => const ResetEmailSent();
      break;

    default:
      return MaterialPageRoute<void>(
        builder: (context) => Container(),
        settings: settings,
      );
  }
  return MaterialPageRoute(builder: builder, settings: settings);
}
