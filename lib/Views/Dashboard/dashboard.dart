import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopsavvy/Controllers/ProductsController.dart';
import 'package:shopsavvy/Models/Utils/Colors.dart';
import 'package:shopsavvy/Models/Utils/Common.dart';
import 'package:shopsavvy/Models/Utils/Images.dart';
import 'package:shopsavvy/Models/Utils/Routes.dart';
import 'package:shopsavvy/Models/Utils/Utils.dart';
import 'package:shopsavvy/Views/Cart/Cart.dart';
import 'package:shopsavvy/Views/Dashboard/QRVerification.dart';
import 'package:shopsavvy/Views/Dashboard/drawer.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../sub-content/products-grid-view.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final ProductsController _productsController = ProductsController();
  List<dynamic> _products = [];

  Map<String, dynamic> filter = {};

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: color3,
        systemNavigationBarColor: color3,
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: color6,
        drawer: DashboardMenu(selection: 1),
        body: SafeArea(
            child: SizedBox(
          height: displaySize.height,
          width: displaySize.width,
          child: Column(
            children: [
              Expanded(
                  flex: 0,
                  child: Container(
                    decoration: BoxDecoration(color: color7),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 18.0, bottom: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (_scaffoldKey.currentState!.hasDrawer &&
                                  _scaffoldKey.currentState!.isEndDrawerOpen) {
                                _scaffoldKey.currentState!.closeEndDrawer();
                              } else {
                                _scaffoldKey.currentState!.openDrawer();
                              }
                            },
                            child: Icon(
                              Icons.menu,
                              color: colorPrimary,
                            ),
                          ),
                          SizedBox(
                              width: displaySize.width * 0.1,
                              child: Image.asset(logo)),
                          GestureDetector(
                            onTap: () {
                              if (CustomUtils.loggedInUser.usertype == '3') {
                                getCartProducts();
                              } else {
                                Routes(context: context)
                                    .navigate(QRVerification());
                              }
                            },
                            child: Icon(
                              (CustomUtils.loggedInUser.usertype == '3')
                                  ? Icons.shopping_cart
                                  : Icons.qr_code,
                              color: colorPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: (_products.isNotEmpty)
                      ? ProductGridView(
                          products: _products,
                        )
                      : const Center(
                          child: Text('No Products Found'),
                        ))
            ],
          ),
        )));
  }

  void getProducts() {
    CustomUtils.showLoader(context);
    _productsController.getProducts(context, filter).then((value) {
      CustomUtils.hideLoader(context);
      setState(() {
        _products = value;
      });
    });
  }

  getCartProducts() {
    Routes(context: context).navigate(Cart(
      products: const [],
    ));
  }
}
