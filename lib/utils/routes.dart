import 'package:debug_no_cell/pages/login_page.dart';
import 'package:flutter/material.dart';

switch_initial_page(context) {
  return Navigator.pushNamed(context, "/");
}

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
