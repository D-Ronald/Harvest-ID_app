import 'package:camera_camera/camera_camera.dart';
import 'package:debug_no_cell/pages/login_page.dart';
import 'package:flutter/material.dart';

switch_login_page(context) {
  return Navigator.pushNamed(context, "/Login");
}

switchRegisterToLogin(context) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
}

switch_register_page(context) {
  return Navigator.pushNamed(context, "/Register");
}

switch_view_page(context) {
  return Navigator.pushNamed(context, "/View");
}

openCamera(context) {
  return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => CameraCamera(onFile: (file) => print(file))));
}

switchCapturePage(context) {
  return Navigator.pushNamed(context, "/Capture");
}

switchInitialPage(context) {
  Navigator.of(context).pushNamed("/");
  
}
