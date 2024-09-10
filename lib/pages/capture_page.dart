import 'package:debug_no_cell/pages/preview_page.dart';
import 'package:debug_no_cell/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';


class CapturePage extends StatefulWidget {
  @override
  _CapturePageState createState() => _CapturePageState();
}

class _CapturePageState extends State<CapturePage> {
  File? archive;

Future<void> _cropImage(File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings:[  
        AndroidUiSettings(
         toolbarTitle: 'Cortar Imagem',
         toolbarColor: Color.fromRGBO(19,56,58,1),
         toolbarWidgetColor: Colors.white,
         initAspectRatio: CropAspectRatioPreset.square,
         lockAspectRatio: true,
         cropFrameStrokeWidth: 1, 
         cropFrameColor: Colors.white, 
         cropGridColor: Colors.white, 
         hideBottomControls: true,

        ),
      ],
    );


    if (croppedFile != null) {
      setState(() {
        archive = File(croppedFile.path);
      });
      showPreview(context, archive);
    }
  }

  void showPreview(context, File? file) async {
    file = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PreviewPage(
                  archive: file,
                  cultureId: '',
                  propertyId: '',
                ))) as File?;
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
                        onFile: (file) async {
                          if (file != null) {
                            await _cropImage(file);
                          }
                        }))))
      ])),
    );
  }
}