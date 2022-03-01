import 'package:flutter/material.dart';
import 'package:wood_cafe/models/menu_model.dart';
import 'package:wood_cafe/models/models.dart';
import 'package:wood_cafe/models/orders.dart';
import 'package:wood_cafe/network.dart';
import 'package:wood_cafe/widgets/widgets.dart';
import 'package:wood_cafe/tools.dart' as tools;

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  late GlobalState globalState;

  late Future<NetworkResponse> _request;

  @override
  void initState() {
    super.initState();
    _request = _getOrders();
  }

  Future<NetworkResponse> _getOrders() {
    return HttpRequest(
      'user/orders/fetch',
    ).send();
  }

  @override
  Widget build(BuildContext context) {
    globalState = Provider.of<GlobalState>(context);
    var cartState = Provider.of<CartState>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'Manage Orders',
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
            leading: IconButton(
              color: Colors.black.withOpacity(0.7),
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).maybePop();
              },
            )),
        body: Column(
          children: [
            Expanded(
                child: RequestWidget(
                    request: _request,
                    allowDragReloading: true,
                    getRequest: _getOrders,
                    onSuccess: (context, response) {
                      List<OrderModel> orders = response.body['data']['orders']
                          .map<OrderModel>((e) => OrderModel.fromJson(e))
                          .toList();
                      print(orders.length);
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          var order = orders[index];
                          return OrderCart(
                            order: order,
                            onDelete: () {
                              // cartState.removeFromCart(food);
                            },
                          );
                        },
                        itemCount: orders.length,
                      );
                    })),
            SizedBox(
                height: 100,
                child: Column(children: [
                  const Divider(),
                  ListTile(
                      onTap: () {},
                      dense: true,
                      title: const Text('Add More Orders',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                          )),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 17,
                      )),
                  // ListTile(
                  //     dense: true,
                  //     onTap: () {},
                  //     title: const Text('Promo code',
                  //         style: TextStyle(
                  //           fontSize: 12,
                  //         )),
                  //     trailing: const Icon(
                  //       Icons.arrow_forward_ios,
                  //       size: 17,
                  //     )),
                ]))
          ],
        ));
  }
}

class OrderCart extends StatelessWidget {
  final OrderModel order;
  final void Function() onDelete;
  const OrderCart({required this.order, required this.onDelete, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      // height: 116,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            // color: Colors.green,
            child: Row(
              children: [
                SizedBox(
                    width: 44,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(MdiIcons.dotsGrid,
                            color: Color.fromARGB(255, 86, 86, 86)),
                      ],
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 24),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(order.status.toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 66, 66, 66))),
                            // Text('₦${tools.formatPrice(100.9)}',
                            //     style: const TextStyle(
                            //       fontSize: 12,
                            //       color: Colors.green,
                            //     )),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Column(
                            children: order.items
                                .map((item) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                item.quantity.toString(),
                                                style: const TextStyle(
                                                    color: Colors.orange),
                                              ),
                                              const SizedBox(width: 16),
                                              Text(item.name,
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 108, 108, 108)),
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ],
                                          ),
                                          Text(
                                            '₦${tools.formatPrice(item.price)}',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList())
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
