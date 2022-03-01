import 'package:flutter/material.dart';
import 'package:wood_cafe/models/menu_model.dart';
import 'package:wood_cafe/network.dart';
import 'package:wood_cafe/screen/menu/menu_detail.dart';

import 'package:wood_cafe/widgets/widgets.dart';

class FoodList extends StatefulWidget {
  const FoodList({Key? key}) : super(key: key);

  @override
  State<FoodList> createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  // Future<List<dynamic>> fetchUsers() async {
  late Future<NetworkResponse> _menuRequest;

  void initState() {
    _menuRequest = _getMenuRequest();
  }

  Future<NetworkResponse> _getMenuRequest() {
    return HttpRequest(
      'user/menu/fetch',
    ).send();
  }

  @override
  Widget build(BuildContext context) {
    return RequestWidget(
      request: _menuRequest,
      onSuccess: (context, response) {
        List<FoodPackage> menuList = response.body['data']['menuList']
            .map<FoodPackage>((element) => FoodPackage.fromJson(element))
            .toList();

        return Container(
          height: 275,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              itemCount: menuList.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Order(food: menuList[index]),
                        ));
                  },
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            height: 160,
                            width: 200,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  menuList[index].featuredImage.toString(),
                                  fit: BoxFit.cover,
                                )),
                          ),
                            Text(
                            menuList[index].name,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              height: 1.5,
                              fontSize: 18.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            menuList[index].description,
                            overflow: TextOverflow.visible,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              height: 1.5,
                              fontSize: 12.0,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 134, 134, 134),
                            ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: 160,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.yellow,
                                    ),
                                    height: 17,
                                    width: 34,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: const [
                                        Icon(Icons.star,
                                            color: Colors.white, size: 10),
                                        Text(
                                          '4.5',
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    )),
                                const Icon(Icons.watch_later, size: 14),
                                Row(
                                  children: [
                                    Text(
                                      '${menuList[index].cookTime.toString()} mins',
                                      style: const TextStyle(
                                        height: 1.5,
                                        fontSize: 12.0,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,

                                        /* letterSpacing: -0.4000000059604645, */
                                      ),
                                    ),
                                  ],
                                ),
                                const Text(
                                  '.',
                                  style: TextStyle(
                                    height: 1.5,
                                    fontSize: 14.0,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,

                                    /* letterSpacing: -0.4000000059604645, */
                                  ),
                                ),
                                Text(
                                  '₦${menuList[index].price.toString()}',
                                  style: const TextStyle(
                                    height: 1.5,
                                    fontSize: 12.0,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10)
                    ],
                  ),
                );
              }),
        );
      },
      allowDragReloading: true,
      getRequest: _getMenuRequest,
    );
  }
}
