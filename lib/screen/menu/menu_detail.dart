// ignore_for_file: sized_box_for_whitespace

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wood_cafe/models/menu_model.dart';
import 'package:wood_cafe/models/models.dart';
import 'package:wood_cafe/routes.dart';
import 'package:wood_cafe/widgets/counterWidget.dart';
import 'package:wood_cafe/tools.dart' as tools;
import 'package:wood_cafe/widgets/widgets.dart';

class Order extends StatefulWidget {
  final FoodPackage food;
  const Order({Key? key, required this.food}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    var cartState = Provider.of<CartState>(context);
    List<FoodPackage> cartList = [];
    cartState.cartList.forEach((k, v) {
      cartList.add(v);
    });
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .45,
                  child: Image.network(widget.food.featuredImage,
                      fit: BoxFit.cover),
                ),
                Positioned(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                        color: Colors.transparent,
                        onPressed: () {
                          Navigator.of(context).maybePop();
                        },
                        child: const Icon(Icons.cancel)),
                    Badge(
                      position: BadgePosition.topEnd(top: 8, end: 0),
                      badgeColor: Colors.red,
                      showBadge: (cartList.isNotEmpty),
                      badgeContent: Text(
                        cartList.length.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      child: IconButton(
                        color: Colors.white,
                        icon: const Icon(MdiIcons.cart),
                        onPressed: () {
                          Navigator.of(context).pushNamed(PageRoutes.cartPage);
                        },
                      ),
                    )
                  ],
                ))
              ]),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.food.name.toString(),
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff000000),
                          ),
                        )),
                    Text('₦${tools.formatPrice(widget.food.price)}',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff000000),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(widget.food.description,
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Image(
                            height: 13,
                            width: 13,
                            image: Svg('assets/timer.svg')),
                        SizedBox(width: 5),
                        Text('Cook Time',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 40, 40, 40),
                              ),
                            )),
                      ],
                    ),
                    Text('${widget.food.cookTime} mins',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 46, 46, 46),
                          ),
                        )),
                  ],
                ),
              ),
              const Divider(height: 5, thickness: 2),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text('Choice of Pasta',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 56, 56, 56),
                      ),
                    )),
              ),
              const Divider(height: 5, thickness: 2),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text('Choice of Protien',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 56, 56, 56),
                      ),
                    )),
              ),
              const Divider(height: 5, thickness: 2),
              Container(
                  alignment: Alignment.center,
                  height: 54,
                  child: Center(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        CounterView(
                          counterCallback: (quantity) {
                            _quantity = quantity;
                          },
                        )
                      ]))),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  var state = Provider.of<GlobalState>(context, listen: false);
                  var data = Map<String, dynamic>.from(widget.food.data);
                  data['quantity'] = _quantity;
                  state.cartState.addToCart(FoodPackage.fromJson(data));
                },
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5)),
                      width: MediaQuery.of(context).size.width * .9,
                      height: 50,
                      child: Center(
                        child: Text(
                            'ADD TO ORDER  ₦${tools.formatPrice(widget.food.price)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.7,
                            )),
                      ))
                ]),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
