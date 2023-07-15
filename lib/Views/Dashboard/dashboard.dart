import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopsavvy/Controllers/ProductsController.dart';
import 'package:shopsavvy/Models/DB/User.dart';
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
  final CustomUtils _customUtils = CustomUtils();
  List<dynamic> _products = [];

  Map<String, dynamic> filter = {};

  User? storedUser;
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    Future.delayed(Duration.zero, () {
      getProducts();
    });
  }

  void _loadUserData() async {
    storedUser = await User.getUser();
    setState(() {
      isDataLoaded = true;
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
                        isDataLoaded
                            ? GestureDetector(
                                onTap: () {
                                  if (storedUser!.usertype == '3') {
                                    getCartProducts();
                                  } else {
                                    Routes(context: context)
                                        .navigate(QRVerification());
                                  }
                                },
                                child: Icon(
                                  (storedUser!.usertype == '3')
                                      ? Icons.shopping_cart
                                      : Icons.qr_code,
                                  color: colorPrimary,
                                ),
                              )
                            : CircularProgressIndicator()
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
      )),
    );
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
