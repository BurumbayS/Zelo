import 'package:ZeloApp/models/Address.dart';
import 'package:json_annotation/json_annotation.dart';
import 'OrderItem.dart';

part 'Order.g.dart';

enum OrderStatus {
  NEW,
  DELIVERING,
  COMPLETED
}

@JsonSerializable()

class Order {
  int id;
  @JsonKey(name: 'place_id')
  int placeID;
  @JsonKey(name: 'status')
  OrderStatus orderStatus;
  @JsonKey(name: 'order_items')
  List<OrderItem> orderItems;
  @JsonKey(name: 'delivery_price')
  int deliveryPrice;
  @JsonKey(name: 'customer_id')
  int customerID;
  int price;
  @JsonKey(name: 'delivery_address')
  Address deliveryAddress;
  @JsonKey(name: 'contact_phone')
  String contactPhone;

  Order() {
    orderStatus = OrderStatus.NEW;
    orderItems = new List();
    deliveryAddress = new Address();
    deliveryPrice = 0;
    contactPhone = '';
  }

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
}