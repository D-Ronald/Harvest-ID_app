import 'package:debug_no_cell/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:image_picker/image_picker.dart';

class CapturePage extends StatefulWidget {
  @override
  _CapturePageState createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            spacing(context, 40),
            genericIconButton(
              context: context,
              backgroundColor: darkGreenBase,
              textColor: white_base,
              text: "Tirar uma foto",
              icon: Icon(Icons.camera),
              percentageHeight: 10,
              percentageWidth: 70,
              function: () {
                openCamera(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          spacing(context, 40),
          genericIconButton(
              context: context,
              backgroundColor: darkGreenBase,
              textColor: white_base,
              text: "Tirar uma foto",
              icon: Icon(Icons.camera),
              percentageHeight: 10,
              percentageWidth: 70,
              function: () {
                openCamera(context);
              })
        ],
      ),
    ));
  }
