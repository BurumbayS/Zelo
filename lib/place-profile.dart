import 'package:ZeloApp/models/Network.dart';
import 'package:ZeloApp/order-page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stretchy_header/stretchy_header.dart';
import 'package:flutter/cupertino.dart';
import './models/Place.dart';

class PlaceProfile extends StatefulWidget {
  Place _place;

  PlaceProfile(Place place) {
    _place = place;
  }

  @override
  State<StatefulWidget> createState() {
    return new PlaceProfileState(_place);
  }
}

class PlaceProfileState extends State<PlaceProfile>{
  List<int> _selectedItems = new List();
  Map<int, int> _itemOrderCount = new Map();
  Place _placeInfo;

  PlaceProfileState(Place place) {
    _placeInfo = place;
  }

  void _makeOrder(itemIndex) {
    setState(() {
      _selectedItems.add(itemIndex);
      _itemOrderCount[itemIndex] = 1;
    });
  }

  void _increaseOrderCount(itemIndex) {
    setState(() {
      _itemOrderCount[itemIndex]++;
    });
  }

  void _decreaseOrderCount(itemIndex) {
    setState(() {
      _itemOrderCount[itemIndex]--;
      if (_itemOrderCount[itemIndex] == 0) {
        _selectedItems.remove(itemIndex);
      }
    });
  }

  double _heightOfItem(itemIndex) {
    if (_selectedItems.contains(itemIndex)) { return 50; }

    return 0;
  }

  String _getItemOrderCount(itemIndex) {
    return _itemOrderCount[itemIndex].toString();
  }

  bool _shouldShowOrderTotal() {
    if (_selectedItems.length > 0) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: StretchyHeader.listViewBuilder(
              headerData: HeaderData(
                  headerHeight: 250,
                  header: Image.network(
                    Network.host + _placeInfo.wallpaper,
                    fit: BoxFit.cover,
                  ),
                  highlightHeaderAlignment: HighlightHeaderAlignment.top,
                  highlightHeader: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: <Widget>[

                          Container(
                              margin: EdgeInsets.only(top: 45, left: 15),
                              height: 40,
                              width: 40,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  color: Colors.grey[200].withOpacity(0.5)
                              ),

                              child: Image.asset('assets/images/arrow.png')
                          ),

                          Expanded(
                            child: Container(

                            ),
                          ),

                          Container(
                            margin: EdgeInsets.only(right: 15, top: 45),
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Colors.grey[200].withOpacity(0.5)
                            ),

                            child: Icon(
                                Icons.search
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ),
              itemCount: 15,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildHeader();
                }

                return _buildMenuItem(context, index);
              },
            ),
          ),

          AnimatedPositioned(
            bottom: _shouldShowOrderTotal() ? 50 : -50,
            duration: Duration(milliseconds: 200),
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
                color: Colors.blue[400],
                textColor: Colors.white,
                splashColor: Colors.blue[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)
                ),

                child: Text(
                    '2  за  KZT 2500',
                    style: GoogleFonts.openSans(
                      fontSize: 22,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold
                    )
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      CupertinoPageRoute(
                          fullscreenDialog: true,
                          builder: (context) => OrderPage()
                      )
                  );
                },
              ),
            ),
          )

        ],
      )
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(10),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              _placeInfo.name,
              style: GoogleFonts.capriola(
                color: Colors.black,
                fontSize: 24,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
              )
          ),

          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Text(
                _placeInfo.description,
                style: GoogleFonts.capriola(
                  color: Colors.grey[500],
                  fontSize: 15,
                  decoration: TextDecoration.none,
                )
            ),
          )

        ],
      ),
    );
  }

  Widget _buildMenuItem(context, itemIndex) {
    return InkWell(
        onTap: () {
          _dishInfoModal(context, itemIndex);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container (
              child: Row(
                children: <Widget>[
                  Expanded(

                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Салат \"Цезарь\"",
                            maxLines: 1,
                            style: GoogleFonts.capriola(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black
                            ),
                          ),

                          Text(
                            'Зерновая булочка, сырный соус, халапеньо',
                            maxLines: 2,
                          ),

                          Text(
                            '1600 ₸',
                            style: GoogleFonts.capriola(
                                color: Colors.blue[300],
                                fontSize: 15
                            ),
                          )
                        ],
                      ),
                    ),

                  ),

                  Container(
                    width: 100,
                    height: 80,
                    margin: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage('https://www.gastronom.ru/binfiles/images/20191113/b50e9f2a.jpg'),
                          fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),

                  ),
                ],
              ),
            ),

            AnimatedContainer(
              margin: EdgeInsets.only(left: 10, right: 10),
              duration: Duration(milliseconds: 300),
              height: _heightOfItem(itemIndex),
              child: Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      _decreaseOrderCount(itemIndex);
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      child: Image.asset('assets/images/minus.png'),
                    ),
                  ),

                  Container(
                    width: 50,
                    height: 30,
                    child: Text(
                      _getItemOrderCount(itemIndex),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.openSans(
                        color: Colors.grey[700],
                        fontSize: 20,
                      ),
                    ),
                  ),

                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _increaseOrderCount(itemIndex);
                      },
                      child:  Container(
                        height: 30,
                        width: 30,
                        alignment: Alignment.centerLeft,
                        child: Image.asset('assets/images/plus.png'),
                      ),
                    ),
                  ),

                  Text(
                    '2412'
                  )
                ],
              ),
            ),

            Container(
              height: 1,
              margin: EdgeInsets.only(left: 10, right: 5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.all(Radius.circular(0.2)),
              ),
            )
          ],
        ),
    );
  }

  void _dishInfoModal(context, itemIndex) {
    showModalBottomSheet(context: context, builder: (BuildContext bc) {
      return Container(
        height: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 5),
              width: double.infinity,
              alignment: Alignment.center,
              child: Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
              ),
            ),

            Container(
              width: double.infinity,
              height: 200,
              margin: EdgeInsets.only(right: 10, top: 10, left: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage('https://www.gastronom.ru/binfiles/images/20191113/b50e9f2a.jpg'),
                    fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),

            ),

            Padding(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Text(
                'Салат \"Цезарь\"',
                 style: GoogleFonts.capriola(
                    color: Colors.black,
                    fontSize: 18,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                 )
              )
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10, top: 5),
                child: Text(
                  'Зерновая булочка, сырный соус, халапеньо',
                ),
              ),
            ),
  
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
              width: double.infinity,
              height: 50,
              child: FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                splashColor: Colors.blue[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Text(
                    'Заказать',
                    style: GoogleFonts.capriola(
                      fontSize: 18,
                      decoration: TextDecoration.none,
                    )
                ),
                onPressed: () {
                  _makeOrder(itemIndex);
                  Navigator.pop(context);
                },
              ),

            )

          ],
        ),
      );
    });
  }

}