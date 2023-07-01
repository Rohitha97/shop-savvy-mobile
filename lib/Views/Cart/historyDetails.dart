import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopsavvy/Models/Utils/Colors.dart';
import 'package:shopsavvy/Models/Utils/Common.dart';

class OrderHistory extends StatefulWidget {
  List<dynamic> binsOrder = [];

  OrderHistory({required this.binsOrder});

  @override
  State<OrderHistory> createState() => _CartState(binsOrder: this.binsOrder);
}

class _CartState extends State<OrderHistory> {
  List<dynamic> binsOrder = [];

  _CartState({required this.binsOrder});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: color3,
        systemNavigationBarColor: color3,
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: color6,
      body: SafeArea(
          child: SizedBox(
        height: displaySize.height,
        width: displaySize.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                Expanded(
                    flex: 0,
                    child: Container(
                        decoration: BoxDecoration(color: colorPrimary),
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 18.0,
                                bottom: 15.0),
                            child: Stack(children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: color9,
                                ),
                              ),
                              Center(
                                  child: Text(
                                "Order Details",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: color6,
                                    fontSize: 16.0),
                              )),
                            ])))),
                Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListView(
                        children: [
                          for (dynamic data in binsOrder) getCard(data)
                        ],
                      ),
                    ))
              ],
            )
          ],
        ),
      )),
    );
  }

  getCard(data) {

    print(data['productdata']['name']);

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (data['productdata']['name'].toString().length>40)?('${data['productdata']['name'].toString().substring(0,40)}..'):data['productdata']['name'].toString(),
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: color3),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "Qty : ${data['qty']}",
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                        color: color3),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
