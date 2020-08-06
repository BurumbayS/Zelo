import 'package:ZeloApp/models/MenuItem.dart';
import 'package:ZeloApp/order-page.dart';

class OrderItem {
  int id;
  String name;
  int price;
  int count;

  static OrderItem fromMenuItem(MenuItem item) {
    OrderItem orderItem = new OrderItem();
    orderItem.id = item.id;
    orderItem.name = item.name;
    orderItem.price = item.price;
    orderItem.count = 1;

    return orderItem;
  }

  int totalPrice() {
    return count * price;
  }

}