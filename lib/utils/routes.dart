import 'package:flutter/material.dart';

switch_initial_page(context){
  return Navigator.pushNamed(context, "/");
}

switch_login_page(context){
  return Navigator.pushNamed(context, "/Login");
}

switch_register_page(context){
  return Navigator.pushNamed(context, "/Register");
}

switch_view_page(context){
  return Navigator.pushNamed(context, "/View");
}