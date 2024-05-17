
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addItem(Map<String, dynamic> item) {
    // Check if the item already exists in the cart
    int index = _items.indexWhere((element) => element['id'] == item['id']);
    if (index != -1) {
      _items[index]['quantity'] += 1;
    } else {
      // Add a new item with initial quantity 1
      item['quantity'] = 1;
      _items.add(item);
    }
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void incrementQuantity(int index) {
    _items[index]['quantity']++;
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_items[index]['quantity'] > 1) {
      _items[index]['quantity']--;
    } else {
      removeItem(index);
    }
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0;
    for (var item in _items) {
      // Add null checks before type casting and convert price to double
      if (item['price'] != null && item['quantity'] != null) {
        total += (item['price'].toDouble()) * (item['quantity'] as int);
      }
    }
    return total;
  }
}
