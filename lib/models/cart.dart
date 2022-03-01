import 'package:flutter/material.dart';
import 'package:wood_cafe/models/menu_model.dart';
import 'package:wood_cafe/tools.dart' as tools;

class CartState extends ChangeNotifier {
  final Map<String, FoodPackage> _cartList = {};
  Map<String, FoodPackage> get cartList {
    return _cartList;
  }

  void addToCart(FoodPackage product) {
    String cartId = product.menuId;
    if (_cartList.containsKey(cartId)) {
      _cartList.remove(cartId);
    }

    _cartList[cartId] = product;
    notifyListeners();
    tools.showToast('Added to cart');
  }

  void removeFromCart(FoodPackage product) {
    String cartId = product.menuId;
    _cartList.remove(cartId);
    notifyListeners();
    tools.showToast('Removed from cart');
    tools.putInStore(
        'cart_list', _cartList.keys.map((e) => _cartList[e]!.data).toList());
  }

  void clearCart() {
    _cartList.clear();
    notifyListeners();
    tools.showToast('Cart cleared');
    tools.removeFromStore('cart_list');
  }
}
