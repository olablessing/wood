class OrderModel {
  late String orderId;
  List<Items> items = [];
  late String deliveryType;
  late String status;
  late DateTime createdAt;
  String? updatedAt;
  OrderModel.fromJson(json) {
    orderId = json['orderId'] ?? '';
    if (json['items'] != null) {
      json['items'].forEach((v) {
        items.add(Items.fromJson(v));
      });
    }
    deliveryType = json['deliveryType'] ?? '';
    status = json['status'] ?? '';
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = json['updatedAt'];
  }
}

class Items {
  late String name;
  late String menuId;
  late String description;
  late int quantity;
  late double price;

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    menuId = json['menuId'];
    description = json['description'];
    quantity = json['quantity'];
    price = double.parse(json['price'].toString());
  }
}
