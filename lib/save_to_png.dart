// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:image/image.dart';
import 'package:barcode_image/barcode_image.dart';

// Helper Function to only take 2 digits of the int n
String twoDigits(int n) {
  if (n >= 10) {
    return "$n";
  } else {
    return "0$n";
  }
}

void savePNG({required String data, required BuildContext context}) async {
  final image = img.Image(width: 300, height: 300);

  DateTime now = DateTime.now();
  String filename = "${now.year}"
      "${twoDigits(now.month)}"
      "${twoDigits(now.day)}"
      "-${twoDigits(now.hour)}"
      "${twoDigits(now.minute)}"
      "${twoDigits(now.second)}"
      ".png";

  // Background Color
  fill(image, color: ColorRgb8(255, 255, 255));

  // Draw the barcode
  drawBarcode(image, Barcode.qrCode(), data);

  // Get the external storage directory
  Directory? externalDir = await getExternalStorageDirectory();
  if (externalDir != null) {
    // Save the image to the external storage directory
    // ignore: unnecessary_new
    File file = new File("/storage/emulated/0/Download/$filename");
    file.writeAsBytesSync(encodePng(image));

    // Show an alert box of successful attempt of saving the barcode image
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text('Image saved successfully to ${file.path}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  } else {
    // Handle the case where externalDir is null (failed to get the directory)
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Unable to get external storage directory'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
