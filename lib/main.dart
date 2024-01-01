import 'package:flutter/material.dart';
import 'barcode_wdgt.dart';
import 'save_to_png.dart' as savep;
import 'save_to_svg.dart' as saves;

void main() {
  // Main Program: The App runs here.
  runApp(const MyApp());
}

// The root of the entire application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}

// Main Page
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _codeData = "Whaddya' expect from an empty box?";

  @override
  Widget build(BuildContext context) {
    double hei = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    double leftright = 30;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "QR Code Generator",
          style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Colors.white),
        ),
        backgroundColor: const Color(0xFF352870),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFF5038AC),
      body: Padding(
        padding: EdgeInsets.only(top: hei / 30, bottom: hei / 30),
        child: SafeArea(
          child: ListView(
            children: [
              // Sub-Widget: Container to show the QR Code (barcode_wdgt.dart)
              BarcodeShow(data: _codeData),

              Container(
                margin: EdgeInsets.only(
                    top: 35, left: leftright + 10, right: leftright + 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Text(
                            "Insert something below\nto generate a QR Barcode!",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                fontSize: wid / 25,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: 20,
                          left: leftright,
                          right: leftright,
                          bottom: 25),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 229, 229, 229),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextField(
                          maxLines: 4,
                          onChanged: (value) {
                            setState(() {
                              if (value == "") {
                                _codeData =
                                    "Whaddya' expect from an empty box?";
                              } else {
                                _codeData = value;
                              }
                            });
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter your link or text here"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 35, left: 70, right: 70),
                child: SizedBox(
                  width: 350,
                  height: 45,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      savep.savePNG(data: _codeData, context: context);
                    },
                    child: const Text(
                      "Save QR Code to PNG",
                      style: TextStyle(
                        color: Color.fromARGB(255, 57, 21, 119),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 15, left: 70, right: 70),
                child: SizedBox(
                  width: 350,
                  height: 45,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      saves.saveSVG(data: _codeData, context: context);
                    },
                    child: const Text(
                      "Save QR Code to SVG",
                      style: TextStyle(
                        color: Color.fromARGB(255, 57, 21, 119),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
