import 'package:debug_no_cell/pages/dashboard_page.dart';
import 'package:debug_no_cell/pages/preview_page.dart';
import 'package:debug_no_cell/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CapturePage extends StatefulWidget {
  @override
  _CapturePageState createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  File? archive;

  showPreview(context, File? file) async {
    file = Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PreviewPage(
                  archive: file,
                  cultureId: '',
                  propertyId: '',
                ))) as File?;
    MaterialPageRoute(builder: (_) => DashboardPage(archive: archive));
    if (file != null) {
      setState(() => archive = file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        spacing(context, 50),
        genericIconButton(
            context: context,
            backgroundColor: darkGreenBase,
            textColor: whiteBase,
            text: "Tire uma foto",
            icon: Icon(Icons.camera),
            percentageHeight: 8,
            percentageWidth: 50,
            function: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => CameraCamera(
                        onFile: (file) => showPreview(context, file)))))
      ])),
    );
  }
}
