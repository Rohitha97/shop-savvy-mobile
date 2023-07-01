import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shopsavvy/Controllers/ProductsController.dart';
import 'package:shopsavvy/Models/Utils/Routes.dart';
import 'package:shopsavvy/Models/Utils/Utils.dart';
import 'package:shopsavvy/Views/Cart/Cart.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QRVerification extends StatefulWidget {
  QRVerification({Key? key}) : super(key: key);

  @override
  State<QRVerification> createState() => _QRVerificationState();
}

class _QRVerificationState extends State<QRVerification> {
  final ProductsController _productsController = ProductsController();

  @override
  void initState() {
    super.initState();
    // Start scanning QR code as soon as widget is initialised
    scanQR();
  }

  Future<void> scanQR() async {
    String scanResult;
    // Platform messages may fail, so use a try/catch PlatformException.
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      if (!mounted) return;
      onBarcodeDetected(scanResult);
    } catch (e) {
      if (!mounted) return;
    }
  }

  Future<void> goToCart(String code) async {
    CustomUtils.showLoader(context);
    await _productsController
        .getCartPaidProducts(context, {'id': code}).then((value) {
      CustomUtils.hideLoader(context);
      print(value);
      Routes(context: context).navigateReplace(Cart(
        products: value['products'],
        code: code,
      ));
    });
  }

  void onBarcodeDetected(String code) {
    if (code.contains("shopsavvy_")) {
      String extractedCode = code.replaceAll('shopsavvy_', '');
      goToCart(extractedCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Verification'),
      ),
      body: Center(
        child: Text('Scan QR code to verify'),
      ),
    );
  }
}
