// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:barcode_image/barcode_image.dart';

String twoDigits(int n) {
  if (n >= 10) {
    return "$n";
  } else {
    return "0$n";
  }
}

void saveSVG({required String data, required BuildContext context}) async {
  DateTime now = DateTime.now();
  String filename = "${now.year}"
      "${twoDigits(now.month)}"
      "${twoDigits(now.day)}"
      "-${twoDigits(now.hour)}"
      "${twoDigits(now.minute)}"
      "${twoDigits(now.second)}"
      ".svg";

  Directory? externalDir = await getExternalStorageDirectory();
  if (externalDir != null) {
    String filePath = "/storage/emulated/0/Download/$filename";
    Barcode bc = Barcode.qrCode();

    File file = File(filePath);
    file.writeAsStringSync(
      bc.toSvg(
        data,
        width: 200,
        height: 200,
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text('SVG saved successfully to ${file.path}'),
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
