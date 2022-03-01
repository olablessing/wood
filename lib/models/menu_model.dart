class FoodPackage {
  late String menuId;
  late String name;
  late String description;
  late String cookTime;
  late double price;
  late List<String> protein;
  late List<String> carbohydrate;
  late String featuredImage;
  late Map<String, dynamic> data;

  int quantity = 1;
  FoodPackage.fromJson(Map<String, dynamic> json) {
    data = json;
    menuId = json['menuId'];
    name = json['name'] ?? '';
    description = json['description'] ?? '';
    cookTime = json['cookTime'] ?? '';
    price = double.parse(json['price'].toString());
    protein = json['protein'].cast<String>();
    carbohydrate = json['carbohydrate'].cast<String>();
    featuredImage = json['featuredImage'] ?? '';
    quantity = json['quantity'] ?? 1;
  }
}
