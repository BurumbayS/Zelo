import 'package:ZeloApp/models/Address.dart';
import 'package:flutter/material.dart';
import 'completed-order-page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'map-page.dart';
import 'package:dotted_line/dotted_line.dart';
import './models/OrderItem.dart';

enum SectionType {
  order,
  address,
  contactNumber,
  payment
}
extension SectionTypeExtension on SectionType {
  String get title {
    switch (this) {
      case SectionType.order:
        return "Ваш заказ";
      case SectionType.address:
        return "Адрес доставки";
      case SectionType.contactNumber:
        return "Контактный номер";
      case SectionType.payment:
        return "К оплате";
    }
  }

  int get rowCount {
    switch (this) {
      case SectionType.order:
        return 2;
      case SectionType.address:
        return 1;
      case SectionType.contactNumber:
        return 1;
      case SectionType.payment:
        return 1;
    }
  }
}

class OrderPage extends StatefulWidget{
  List<OrderItem> _orderItems;

  OrderPage(List<OrderItem> items) {
    _orderItems = items;
  }

  @override
  State<StatefulWidget> createState() {
    return new OrderPageState(_orderItems);
  }
}

class OrderPageState extends State<OrderPage> {
  Address _address = new Address();
  String _contactNumber = '';
  int _section = 0;
  int _row = 0;
  List<SectionType> _sections = [SectionType.order, SectionType.address, SectionType.contactNumber, SectionType.payment];
  List<OrderItem> _orderItems;

  final _phoneTextFieldController = TextEditingController();
  FocusNode _focus = new FocusNode();

  bool _orderCompleted() {
    return (_address.firstAddress != '' && _contactNumber.length == 11);
  }

  int _itemsCount() {
    var itemsCount = 0;

    _sections.forEach((section) {
      itemsCount++;
      itemsCount += (section == SectionType.order) ? _orderItems.length : section.rowCount;
    });

    return itemsCount;
  }

  void _increaseOrderCount(OrderItem item) {
    setState(() {
      item.count++;
    });
  }

  void _decreaseOrderCount(OrderItem item) {
    setState(() {
      item.count--;
      if (item.count == 0) {
        _orderItems[_menuItems[itemIndex].id] = null;
        _selectedItemsCount--;
      }
    });
  }

  OrderPageState(List<OrderItem> items) {
    _orderItems = items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          "Оформление заказа",
          style: TextStyle(
            color: Colors.black
          ),
        ),
      ),

      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack (
          children: <Widget>[
            ListView.builder(
                itemCount: _itemsCount(),
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 120),
                itemBuilder: (context, i) {
                  SectionType currentSection = _sections[_section];

                  if (currentSection == SectionType.order && _row > _orderItems.length) {
                    (_section == _sections.length - 1) ? _section = 0 : _section++;
                    currentSection = _sections[_section];
                    _row = 0;
                  } else
                  if (_row > currentSection.rowCount) {
                    (_section == _sections.length - 1) ? _section = 0 : _section++;
                    currentSection = _sections[_section];
                    _row = 0;
                  }

                  if (_row == 0) {
                    _row++;
                    return _buildListHeader(currentSection.title);
                  }

                  _row++;

                  switch (_sections[_section]) {
                    case SectionType.order:
                      return _orderItem(context, _orderItems[_row - 2]);
                    case SectionType.address:
                      return _addressItem();
                    case SectionType.contactNumber:
                      return _contactNumberItem();
                    case SectionType.payment:
                      return _paymentItem();
                    default:
                      return Container();
                  }
                }
            ),

            Positioned(
              bottom: (_focus.hasFocus) ? -50 : 50,
              left: MediaQuery.of(context).size.width * 0.1,

              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),]
                ),

                child: FlatButton(
                  color: (_orderCompleted()) ? Colors.blue[400] : Colors.grey,
                  textColor: Colors.white,
                  splashColor: (_orderCompleted()) ? Colors.blue[700] : Colors.grey[0],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)
                  ),

                  child: Text(
                      'Оформить заказ',
                      style: GoogleFonts.openSans(
                          color: (_orderCompleted()) ? Colors.white : Colors.grey[300],
                          fontSize: 22,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold
                      )
                  ),
                  onPressed: () {
                    Navigator.push(context, CupertinoPageRoute(
                        builder: (context) => CompletedOrderPage()
                    ));
                  },
                ),
              ),
            )
          ],
        )
      )
    );
  }

  Widget _buildListHeader(String title) {
    return Padding (
      padding: EdgeInsets.only(top: 20),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              title,
              style: GoogleFonts.openSans(
                  color: Colors.grey[800],
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),

          Divider()
        ],
      ),
    );
  }

  Widget _orderItem(context, OrderItem item) {
    return InkWell(
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row (
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16, right: 10),
                child: Text(
                  item.count.toString() + 'x',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),

              Expanded(
                  child: Text(
                    item.name,
//              maxLines: 2,
                    style: GoogleFonts.capriola(
                        fontSize: 16
                    ),
                  )
              ),

              Padding(
                padding: EdgeInsets.only(right: 16),
                child: Text(
                  'KZT ' + item.totalPrice().toString(),
                  style: TextStyle(
                      fontSize: 18
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 16),
                    height: 20,
                    width: 20,
                    child: Image.asset('assets/images/minus.png'),
                  ),
                ),

                Expanded(
                    child: Container()
                ),

                GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 16),
                    height: 20,
                    width: 20,
                    child: Image.asset('assets/images/plus.png'),
                  ),
                )
              ],
            ),
          ),

          Divider()
        ],
      ),
    );
  }

  Widget _addressItem() {
    return InkWell(
      onTap: () async {
        final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapSearchPage(_address),
            )
        );

        if (result != null) {
          setState(() {
            _address = result;
          });
        }
      },
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            child: _addressLine(),
          ),

          Divider()
        ],
      )
    );

  }

  Widget _addressLine() {
    if (_address.firstAddress == '') {
      return Text(
        'Укажите адрес',
        style: GoogleFonts.openSans(
            fontSize: 18,
            color: Colors.grey[500]
        ),
      );
    }

    return Column (
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          _address.firstAddress,
          maxLines: 2,
          style: GoogleFonts.openSans(
              fontSize: 16,
              color: Colors.black
          ),
        ),

        Text(
          _address.secondAddress,
          style: GoogleFonts.openSans(
              fontSize: 14,
              color: Colors.grey[700]
          ),
        )
      ],
    );

  }

  Widget _contactNumberItem() {
    return Column (
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding (
          padding: EdgeInsets.only(left: 16),
          child: TextFormField(
            controller: _phoneTextFieldController,
            focusNode: _focus,
            keyboardType: TextInputType.number,
            onChanged: (number) {
                setState(() {
                  _contactNumber = number;
                });
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Укажите контактный номер',
              hintStyle: GoogleFonts.openSans(
                color: Colors.grey[500]
              )
            ),
            style: GoogleFonts.openSans(
              fontSize: 18
            ),
          ),
        ),

        Divider()
      ],
    );
  }

  Widget _paymentItem() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Продукты',
                style: GoogleFonts.openSans(
                    fontSize: 17
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: DottedLine(
                    dashColor: Colors.grey[400],
                  ),
                )
              ),

              Text(
                'KZT 2300',
                style: GoogleFonts.openSans(
                  fontSize: 17,
                ),
              )
            ],
          ),

          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: <Widget>[
                Text(
                  'Доставка',
                  style: GoogleFonts.openSans(
                      fontSize: 17
                  ),
                ),

                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: DottedLine(
                        dashColor: Colors.grey[400],
                      ),
                    )
                ),

                Text(
                  'KZT 2300',
                  style: GoogleFonts.openSans(
                      fontSize: 17,
                  ),
                )
              ],
            ),
          ),

          Row(
            children: <Widget>[
              Text(
                'ВСЕГО',
                style: GoogleFonts.openSans(
                    fontSize: 17
                ),
              ),

              Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: DottedLine(
                      dashColor: Colors.grey[400],
                    ),
                  )
              ),

              Text(
                'KZT ' + _address.distance.toString(),
                style: GoogleFonts.openSans(
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}