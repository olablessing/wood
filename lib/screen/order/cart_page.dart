import 'package:flutter/material.dart';
import 'package:wood_cafe/models/menu_model.dart';
import 'package:wood_cafe/models/models.dart';
import 'package:wood_cafe/models/orders.dart';
import 'package:wood_cafe/network.dart';
import 'package:wood_cafe/routes.dart';
import 'package:wood_cafe/widgets/widgets.dart';
import 'package:wood_cafe/tools.dart' as tools;

enum DeliveryType {
  pickup,
  delivery,
}

extension DeliveryTypeExtension on DeliveryType {
  String get name {
    switch (this) {
      case DeliveryType.pickup:
        return 'pickup';
      case DeliveryType.delivery:
        return 'delivey';
      default:
        return '';
    }
  }
}

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var _deliveryType = DeliveryType.pickup;
  late GlobalState globalState;
  double totalFoodPrice = 0;
  double deliveryFee = 300;
  List<FoodPackage> cartList = [];
  String? _couponCode;
  bool _counponValid = false;

  @override
  Widget build(BuildContext context) {
    globalState = Provider.of<GlobalState>(context);
    var cartState = Provider.of<CartState>(context);

    cartList = [];
    cartState.cartList.forEach((k, v) {
      cartList.add(v);
    });

    totalFoodPrice = 0;
    for (var e in cartList) {
      totalFoodPrice += e.price * e.quantity;
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'Cart Page',
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
            leading: IconButton(
              color: Colors.black.withOpacity(0.7),
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).maybePop();
              },
            )),
        body: Column(
          children: [
            Expanded(
                child: cartList.isNotEmpty
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          var food = cartList[index];
                          return CartCard(
                            food: food,
                            onDelete: () {
                              cartState.removeFromCart(food);
                            },
                          );
                        },
                        itemCount: cartList.length,
                      )
                    : ErrorDisplay(
                        onRefresh: () {
                          Navigator.of(context).pushNamed(PageRoutes.home);
                        },
                        // dense: true,
                        title: 'Oops! no item has been added to your cart',
                        actionText: 'Add to cart')),
            SizedBox(
                height: MediaQuery.of(context).size.height * .43,
                child: Column(children: [
                  const Divider(),
                  Expanded(
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Subtotal',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text('₦${tools.formatPrice(totalFoodPrice)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ))
                            ],
                          ),
                        ),
                        RadioListTile<DeliveryType>(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.0),
                            dense: true,
                            value: DeliveryType.pickup,
                            groupValue: _deliveryType,
                            onChanged: (v) {
                              setState(() {
                                _deliveryType = v!;
                              });
                            },
                            title: Text('Pick up in resturant')),
                        RadioListTile<DeliveryType>(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.0),
                            dense: true,
                            value: DeliveryType.delivery,
                            groupValue: _deliveryType,
                            onChanged: (v) {
                              setState(() {
                                _deliveryType = v!;
                              });
                            },
                            secondary: _deliveryType == DeliveryType.delivery
                                ? Text('₦${tools.formatPrice(deliveryFee)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(.75),
                                      fontSize: 11.8,
                                    ))
                                : null,
                            title: Row(
                              children: const [
                                Text('Delivery  '),
                                Icon(MdiIcons.truckDeliveryOutline, size: 16),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Total (incl. VAT)',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Text(
                                  '₦ ${tools.formatPrice(totalFoodPrice + (_deliveryType == DeliveryType.delivery ? deliveryFee : 0))}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ))
                            ],
                          ),
                        ),
                        ListTile(
                            onTap: () {
                              Navigator.of(context).pushNamed(PageRoutes.home);
                            },
                            dense: true,
                            title: const Text('Add More Items',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                )),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 17,
                            )),
                        ExpansionTile(
                          title: const Text('Promo code',
                              style: TextStyle(
                                fontSize: 12,
                              )),
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          style: const TextStyle(fontSize: 12),
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                              filled: true,
                                              border: const OutlineInputBorder(
                                                  gapPadding: 0,
                                                  borderSide: BorderSide(
                                                      color: Colors.teal)),
                                              labelText: "Coupon code",
                                              errorText: !_counponValid &&
                                                      _couponCode != null
                                                  ? 'Invalid coupon code'
                                                  : null),
                                          validator:
                                              tools.Validators.isNotEmpty,
                                          onFieldSubmitted: (value) {
                                            _couponCode = value;
                                            _validateCoupon();
                                          },
                                          onChanged: (value) {
                                            _couponCode = value;
                                          }),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: (!_counponValid &&
                                                  _couponCode != null)
                                              ? 24.0
                                              : 0,
                                          left: 8),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            fixedSize: Size(
                                                !_counponValid ? 92 : 42, 42),
                                            primary: Color(0XFF22A45D),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(9))),
                                        onPressed: _validateCoupon,
                                        child: _counponValid
                                            ? const Icon(Icons.check)
                                            : const Text('Apply',
                                                style: TextStyle(fontSize: 12)),
                                      ),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       vertical: 10.0, horizontal: 14.0),
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //         fixedSize:
                  //             Size(MediaQuery.of(context).size.width, 42),
                  //         primary: Colors.red,
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(8))),
                  //     onPressed: () {},
                  //     child: const Text(
                  //       'ADD ANOTHER ORDER',
                  //       style: TextStyle(fontSize: 12),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 14.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 42),
                          primary: Color(0XFF22A45D),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9))),
                      onPressed: _checkout,
                      child: const Text(
                        'PROCEED TO CHECKOUT',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ]))
          ],
        ));
  }

  _checkout() async {
    // if (!_counponValid) await _validateCoupon(); // wait and validate again
    String? _address = await showDialog<String?>(
        context: context,
        builder: (context) {
          String? address;
          return AlertDialog(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 12),
              title: const Text("Checkout"),
              content: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3.0, horizontal: 0),
                  child: StatefulBuilder(builder: (context, setState) {
                    return DropdownButtonFormField<String>(
                      hint: Text("Miscellaneous Type",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontFamily: "GilroyMedium",
                                  color: const Color.fromRGBO(0, 0, 0, 0.8))),
                      value: address,
                      validator: tools.Validators.isNotNull,
                      onChanged: (value) {
                        setState(() {
                          address = value;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                                width: 1, color: Colors.black.withAlpha(166))),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      items: locationAddress.map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: const Color.fromRGBO(0, 0, 0, 0.9)),
                          ),
                        );
                      }).toList(),
                    );
                  })));
        });
    if (_address != null) {
      HttpRequest(
        'user/order/add',
        context: context,
        loader: LoaderType.popup,
        body: {
          'items': cartList
              .map((e) => {
                    "name": e.name,
                    "menuId": e.menuId,
                    "quantity": e.quantity,
                    "description": e.description,
                    "price": e.price,
                  })
              .toList(),
          'amount': totalFoodPrice,
          'address': _address,
          "deliveryType": _deliveryType.name,
        },
        onSuccess: (_, result) {
          Navigator.of(context).pushReplacementNamed(PageRoutes.payment,
              arguments: OrderModel.fromJson(result));
        },
      ).send();
    }
  }

  Future<NetworkResponse> _validateCoupon() {
    return HttpRequest(
      'user/coupon/check',
      context: context,
      loader: LoaderType.snack,
      body: {"name": _couponCode},
      onSuccess: (_, result) {
        _counponValid = true;
      },
      onFailure: (_, result) async {
        tools.showToast('Invalid coupon code');
        _counponValid = false;
        return true;
      },
    ).send();
  }
}

class CartCard extends StatelessWidget {
  final FoodPackage food;
  final void Function() onDelete;
  const CartCard({required this.food, required this.onDelete, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      height: 116,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(
                    width: 24,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(food.quantity.toString(),
                            style: const TextStyle(
                              color: Colors.green,
                            )),
                      ],
                    )),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(food.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                              '₦${tools.formatPrice(food.price * food.quantity)}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.green,
                              )),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                food.description,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black54),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: onDelete,
                                  icon: const Icon(Icons.delete_outline,
                                      color: Colors.red, size: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}

const locationAddress = [
  'Female Bronze Annex',
  'Male Bronze',
  'Multiple Purpose Hall(MPH)',
  'Female Silver',
  'Old Gate',
  'Hall B',
  'ClassRoom B8',
  'New Gate',
  'Biology Lab',
  'ClassRoom 2 (R2)',
  'ClassRoom Bl',
  'Wema Bank',
  'ClassRoom 4 (R4)',
  'Chemistry Lab',
  'Male Silver 1',
  'ELT',
  'Classroom 6 (Kb)',
  'New Horizons',
  'Wema Bank',
  'Classroom 1 (R1)',
  'ClassRoom 3 (R3)',
  'Library',
  'Physics lab ',
  'Clinic',
  'Marquee',
  'Female Bronze',
  'ClassRoom B3',
  'Workshop',
  'ClassRoom B6',
  'Male Silver 2',
  'Friendship Center',
  'Adenuga Building (ADG)',
  'Staff Quarters (Behind Male Hostel)',
  'Male Silver 3',
  'ClassRoom B7',
  'Temperance Gate',
  'ClassRoom B9',
  'Glass House',
  'Senior Staff Quarters',
  'ClassRoom 6 (R6)',
  'New Horizons',
];
