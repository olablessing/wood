import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:badges/badges.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wood_cafe/routes.dart';
import 'package:wood_cafe/screen/Homepage1/HomePagewidget.dart';
import 'package:wood_cafe/screen/Homepage1/home2.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Container(
              child: Image.asset('assets/images/Capture1.png',
                  alignment: Alignment.center)),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Badge(
                  badgeContent: Text('3',
                      style: TextStyle(fontSize: 10, color: Colors.orange)),
                  elevation: 0,
                  position: BadgePosition.topEnd(top: 7, end: 15),
                  badgeColor: Colors.white,
                  child: Icon(Icons.notifications_outlined,
                      color: Colors.black, size: 30)),
            )
          ]),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(2.0),
                child: Column(
                  children: <Widget>[
                    Container(
                        height: 235,
                        width: 375,
                        child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              SvgPicture.asset(
                                'assets/svg/Banner.svg',
                                height: 235,
                                width: 375,
                              ),
                              Image.asset(
                                'assets/images/image3.png',
                                height: 185,
                                width: 335,
                              ),
                              SvgPicture.asset('assets/svg/Food is Ready.svg')
                            ])),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Featured Meals',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              'See all',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                      FoodList(),
                      SizedBox(height: 30),
                      Container(
                        height: 170,
                        width: 335,
                        child: SvgPicture.asset('assets/svg/Banner1.svg'),
                      ),
                      Text1(),
                      FoodList(),
                      const SizedBox(height: 43.98),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Our Menu',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(PageRoutes.home);
                            },
                            child: const Text(
                              'See all',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      MenuCard()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
