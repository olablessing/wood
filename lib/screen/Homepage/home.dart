import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:wood_cafe/models/cart.dart';
import 'package:wood_cafe/models/models.dart';
import 'package:wood_cafe/routes.dart';
import 'package:wood_cafe/screen/Homepage/onboarding.dart';
import 'package:wood_cafe/screen/Homepage1/homepage.dart';
import 'package:wood_cafe/screen/auth/loginByPhone.dart';
import 'package:wood_cafe/screen/auth/otp.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wood_cafe/screen/auth/sign_up.dart';
import 'package:wood_cafe/screen/auth/verify_phone_number.dart';
import 'package:wood_cafe/screen/order/cart_page.dart';
import 'package:wood_cafe/screen/checkout/checkin.dart';
import 'package:wood_cafe/screen/checkout/creditCard.dart';
import 'package:wood_cafe/screen/checkout/payment.dart';
import 'package:badges/badges.dart';
import 'package:wood_cafe/screen/menu/menu_detail.dart';
import 'package:wood_cafe/screen/order/order_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;
  late PageController _pageController;

  List<Widget> tabPages = [
    HomeTab(),
    const CartPage(),
    OrderList(),
    const CartPage()
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cartState = Provider.of<CartState>(context);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.restaurant, size: 20),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              elevation: 0,
              showBadge: cartState.cartList.isNotEmpty,
              position: BadgePosition.topEnd(top: -10, end: 3),
              badgeColor: Colors.white,
              badgeContent: Text(cartState.cartList.length.toString(),
                  style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange)),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(MdiIcons.truckDelivery, size: 20),
            label: 'Orders',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
    );
  }

  void onPageChanged(int page) {
    if (page == 3) {
      Provider.of<GlobalState>(context, listen: false).logout();
      Navigator.of(context).pushReplacementNamed(PageRoutes.signIn);
    }
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
