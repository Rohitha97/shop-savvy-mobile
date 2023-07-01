import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopsavvy/Models/Utils/Colors.dart';
import 'package:shopsavvy/Models/Utils/Common.dart';
import 'package:shopsavvy/Models/Utils/Routes.dart';
import 'package:shopsavvy/Views/Widgets/custom_back_button.dart';

class ProductPage extends StatefulWidget {
  dynamic productData;

  ProductPage({Key? key, this.productData}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ProductPage> createState() =>
      _ProductPageState(productData: productData);
}

class _ProductPageState extends State<ProductPage> {
  dynamic productData;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _ProductPageState({this.productData});

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
      body: SafeArea(
          child: SizedBox(
        height: displaySize.height,
        width: displaySize.width,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: displaySize.width * 0.8,
                    width: displaySize.width,
                    child: CachedNetworkImage(
                      imageUrl: productData['img'].toString(),
                      placeholder: (context, url) => CircularProgressIndicator(
                        color: colorPrimary.withOpacity(0.3),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      productData['name'],
                      style: const TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      'Available Qty : ${productData['qty'].toString()}',
                      style: const TextStyle(
                          fontSize: 12.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      productData['formatPrice'].toString(),
                      style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: colorPrimary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      productData['description'].toString(),
                      style: const TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
              child: CustomCustomBackButton(onclickFunction: () {
                Navigator.pop(context);
              }),
            )
          ],
        ),
      )),
      // floatingActionButton: FloatingActionButton(
      //     elevation: 0.0,
      //     backgroundColor: colorPrimary,
      //     onPressed: () {},
      //     child: Icon(
      //       Icons.shopping_bag,
      //       color: color6,
      //     )),
    );
  }
}
