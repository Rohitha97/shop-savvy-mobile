import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
import 'package:shopsavvy/Controllers/ProductsController.dart';
import 'package:shopsavvy/Models/DB/User.dart';
import 'package:shopsavvy/Models/Strings/dashboard.dart';
import 'package:shopsavvy/Models/Utils/Colors.dart';
import 'package:shopsavvy/Models/Utils/Common.dart';
import 'package:shopsavvy/Models/Utils/Routes.dart';
import 'package:shopsavvy/Models/Utils/Utils.dart';
import 'package:shopsavvy/Views/Dashboard/dashboard.dart';
import 'package:shopsavvy/Views/Dashboard/product.dart';
import 'package:shopsavvy/Views/Pre-Payment/Payment.dart';
import 'package:shopsavvy/Views/Widgets/custom_button.dart';
import 'package:visibility_detector/visibility_detector.dart';

class Cart extends StatefulWidget {
  final dynamic products;
  final dynamic code;

  Cart({Key? key, this.products, this.code}) : super(key: key);

  @override
  State<Cart> createState() => _CartState(products: products, code: code);
}

class _CartState extends State<Cart> {
  List<dynamic> products = [];
  dynamic code;
  final ProductsController _productsController = ProductsController();
  bool visible = true;
  bool isLoading = true;
  User? storedUser;
  bool isDataLoaded = false;

  _CartState({required this.products, this.code});

  void _loadUserData() async {
    storedUser = await User.getUser();
    setState(() {
      isDataLoaded = true;
    });
    if (storedUser?.usertype == '3') {
      getProducts();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color3,
        systemNavigationBarColor: color3,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

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
                          bottom: 15.0,
                        ),
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Routes(context: context).back();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: color9,
                              ),
                            ),
                            Center(
                              child: Text(
                                (storedUser?.usertype == '3')
                                    ? cart_title
                                    : 'Order Products',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: color6,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: (products.isNotEmpty)
                        ? Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ListView(
                              children: [
                                for (dynamic data in products) getCard(data),
                              ],
                            ),
                          )
                        : Center(
                            child: Text(
                              (isLoading)
                                  ? 'Loading Your Cart ...'
                                  : cart_empty,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: color8,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
              (products.isNotEmpty)
                  ? Positioned(
                      bottom: 20.0,
                      child: CustomButton(
                        buttonText: (storedUser?.usertype == '3')
                            ? 'Confirm Cart'
                            : 'Verify Order',
                        textColor: color6,
                        backgroundColor: colorPrimary,
                        isBorder: false,
                        borderColor: color6,
                        onclickFunction: () async {
                          CustomUtils.showLoader(context);
                          if (storedUser?.usertype == '3') {
                            _productsController
                                .getCartProducts(context)
                                .then((value) {
                              CustomUtils.hideLoader(context);
                              products = value['products'];
                              double price = 0.0;
                              products.forEach((element) {
                                price +=
                                    double.parse(element['price'].toString());
                              });
                              Routes(context: context).navigate(
                                ReservationPayment(
                                  total: price,
                                  orderNumber: value['orderNumber'],
                                ),
                              );
                            });
                          } else {
                            await _productsController.verifyCart(
                                context, {'id': code}).then((value) {
                              CustomUtils.hideLoader(context);
                              Routes(context: context)
                                  .navigateReplace(const Dashboard());
                            });
                          }
                        },
                      ),
                    )
                  : const SizedBox.shrink(),
              ((storedUser?.usertype == '3')
                  ? Positioned(
                      bottom: 10.0,
                      child: VisibilityDetector(
                        onVisibilityChanged: (VisibilityInfo info) {
                          visible = info.visibleFraction > 0;
                        },
                        key: const Key('visible-detector-key'),
                        child: BarcodeKeyboardListener(
                          bufferDuration: const Duration(milliseconds: 200),
                          onBarcodeScanned: (barcode) {
                            if (!visible) return;
                            CustomUtils.showLoader(context);
                            _productsController
                                .addCartProduct(context, barcode)
                                .then((value) {
                              setState(() {
                                if (products.isNotEmpty) {
                                  products.clear();
                                }
                                products = value;
                              });
                              CustomUtils.hideLoader(context);
                            });
                          },
                          child: Container(),
                        ),
                      ),
                    )
                  : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCard(data) {
    return GestureDetector(
      onTap: () {
        Routes(context: context).navigate(ProductPage(productData: data));
      },
      child: Card(
        child: ListTile(
          title: Text(
            (data['name'].toString().length < 18)
                ? data['name'].toString()
                : '${data['name'].toString().substring(0, 18)}..',
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  'Qty: ${data['qty'].toString()}',
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Text(
                  data['formatPrice'].toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: colorPrimary,
                  ),
                ),
              ),
            ],
          ),
          leading: SizedBox(
            height: displaySize.width * 0.1,
            width: displaySize.width * 0.1,
            child: CachedNetworkImage(
              imageUrl: data['img'].toString(),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          trailing: (storedUser?.usertype == '3')
              ? GestureDetector(
                  onTap: () {
                    _productsController.deleteCartProduct(context,
                        {'id': data['cartid'].toString()}).then((value) {
                      getProducts();
                      CustomUtils.showSnackBarMessage(context, "Cart Updated",
                          CustomUtils.SUCCESS_SNACKBAR);
                    });
                  },
                  child: Icon(
                    Icons.close,
                    color: color12,
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  void getProducts() {
    isLoading = true;
    _productsController.getCartProducts(context).then((value) {
      if (products.isNotEmpty) {
        products.clear();
      }
      setState(() {
        isLoading = false;
        products = value['products'];
      });
    });
  }
}
