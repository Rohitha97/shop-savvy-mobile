import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';
import 'package:shopsavvy/Controllers/ProductsController.dart';
import 'package:shopsavvy/Models/DB/User.dart';
import 'package:shopsavvy/Models/Strings/reservation.dart';
import 'package:shopsavvy/Models/Utils/Colors.dart';
import 'package:shopsavvy/Models/Utils/Common.dart';
import 'package:shopsavvy/Models/Utils/Images.dart';
import 'package:shopsavvy/Models/Utils/Routes.dart';
import 'package:shopsavvy/Models/Utils/Utils.dart';
import 'package:shopsavvy/Models/Validation/FormValidation.dart';
import 'package:shopsavvy/Views/Dashboard/dashboard.dart';
import 'package:shopsavvy/Views/Widgets/custom_button.dart';
import 'package:shopsavvy/Views/Widgets/custom_text_form_field.dart';

class ReservationPayment extends StatefulWidget {
  dynamic total;
  dynamic orderNumber;

  ReservationPayment({Key? key, required this.total, required this.orderNumber})
      : super(key: key);

  @override
  State<ReservationPayment> createState() =>
      // ignore: no_logic_in_create_state
      _ReservationPaymentState(total: total, orderNumber: orderNumber);
}

class _ReservationPaymentState extends State<ReservationPayment> {
  dynamic total;
  dynamic orderNumber;
  _ReservationPaymentState({required this.total, required this.orderNumber});

  final ProductsController _productsController = ProductsController();

  User? storedUser;
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
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
        resizeToAvoidBottomInset: true,
        backgroundColor: color6,
        body: SafeArea(
            child: SizedBox(
          height: displaySize.height,
          width: displaySize.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  flex: 0,
                  child: Container(
                    decoration: BoxDecoration(color: colorPrimary),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 18.0, bottom: 15.0),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: color9,
                                ),
                              )
                            ],
                          ),
                          Center(
                            child: Text(
                              reservation_confirmation.toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: color6,
                                  fontSize: 16.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 5.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 60.0),
                          child: Image.asset(paymentTypes),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 0.0),
                          child: Text("Order Number : $orderNumber"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50.0, vertical: 20.0),
                          child: Text(
                              "Order Total : LKR ${double.parse(total.toString()).toStringAsFixed(2)}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 45.0, vertical: 5.0),
                          child: CustomButton(
                              buttonText: reservation_card_pay,
                              textColor: color6,
                              backgroundColor: colorPrimary,
                              isBorder: false,
                              borderColor: color6,
                              onclickFunction: () async {
                                Map paymentObject = {
                                  "sandbox": true,
                                  "merchant_id": "1223347",
                                  "merchant_secret":
                                      "MTIzODI3MzI2NTI2MDIxOTI1MzUyODc3Nzc2NzMxNDY5OTYwMzEy",
                                  "notify_url":
                                      "https://shop-savvy.000webhostapp.com/",
                                  "order_id": "$orderNumber",
                                  "items": "$orderNumber",
                                  "amount": "$total",
                                  "currency": "LKR",
                                  "first_name": "${storedUser?.name}",
                                  "last_name": "User",
                                  "email": "${storedUser?.email}",
                                  "phone": "0771234567",
                                  "address": "No.1, Galle Road",
                                  "city": "Colombo",
                                  "country": "Sri Lanka"
                                };

                                print(paymentObject);

                                PayHere.startPayment(paymentObject,
                                    (paymentId) {
                                  CustomUtils.showLoader(context);
                                  _productsController
                                      .doPayment(context)
                                      .then((value) {
                                    CustomUtils.hideLoader(context);
                                    Routes(context: context)
                                        .navigateReplace(const Dashboard());
                                  });
                                }, (error) {
                                  print(error);
                                  CustomUtils.showSnackBarMessage(context,
                                      error, CustomUtils.ERROR_SNACKBAR);
                                  Routes(context: context)
                                      .navigateReplace(const Dashboard());
                                }, () {
                                  print("One Time Payment Dismissed");
                                });
                              }),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        )));
  }
}
