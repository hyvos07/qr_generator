import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';

class BarcodeShow extends StatelessWidget {
  final String data;
  const BarcodeShow({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: (wid - 230 - 15)/2,
        right: (wid - 230 - 15)/2
      ),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
          child: BarcodeWidget(
            barcode: Barcode.qrCode(
              errorCorrectLevel: BarcodeQRCorrectionLevel.high,
            ),
            data: data,
            width: 230,
            height: 230,
          ),
        ),
      ),
    );
  }
}
