import 'dart:ui';
import 'package:flutter/material.dart';

const dark_green_base = Color.fromRGBO(19, 56, 58, 1);
const dark_gray_base = Color.fromRGBO(62, 68, 69, 1);
const ligth_gray_base = Color.fromRGBO(217, 217, 217, 1);
const white_base = Color.fromRGBO(255, 255, 255, 1);
const black_base = Color.fromRGBO(0, 0, 0, 1);
const blue_base = Color.fromRGBO(0, 217, 255, 1);

double height(context, int percentage){
  return (MediaQuery.of(context).size.height)*(percentage/100) ;
}

double width(context, percentage){
  return (MediaQuery.of(context).size.width)*(percentage/100) ;
}

Container spacing(context, int height_percentage){
  return Container(
    height: height(context, height_percentage),
  );
}

ElevatedButton generic_button(
  context, background_color, text_color, 
  String text, int percentage_height, 
  int percentage_width, function
  ){
  return ElevatedButton(
    onPressed: (){
      function();
    },
    child: Text(text,
      style: TextStyle(
        color: text_color,
        fontSize: 20,
      ),
    ),
    style: ElevatedButton.styleFrom(
      primary: background_color,
      minimumSize: Size(width(context, percentage_width), height(context, percentage_height)),
    ),
  );
}

ElevatedButton generic_button_icon(
  context, background_color, text_color, 
  String text,Icon icon, int percentage_height, 
  int percentage_width, function
  ){
  return ElevatedButton(
    onPressed: (){
      function();
    },
    style: ElevatedButton.styleFrom(
      primary: background_color,
      minimumSize: Size(width(context, percentage_width), height(context, percentage_height)),
    ),
    child:Container(
      width: width(context, percentage_width),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      icon,
      Text(text,
      style: TextStyle(
        color: text_color,
        fontSize: 20,
      ),
    ),]
  ))
  );
}

TextButton generic_text_button(context, String text, double text_size, text_color){
  return TextButton(
    onPressed: (){},
    child: Text(
      text, 
      style: TextStyle(
        color: text_color,
        fontSize: text_size,
      ),
    )
  );
}

TextField generic_text_box(){
   var a = TextField(
    decoration: InputDecoration(
      iconColor: Color.fromRGBO(27, 94, 32, 1),
      labelText: 'Email',
    ),
  );
  return a;
}

BottomNavigationBar navigation_bar(PageController page_controller, background_color,icon_color){
  return BottomNavigationBar(
    
    backgroundColor: background_color,
    onTap: (int page) {
      page_controller.jumpToPage(page);
    },
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home, color: icon_color),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search, color: icon_color),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add, color: icon_color),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.dashboard,color: icon_color),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person, color: icon_color),
        label: "",
      ),
    ],
  );
}

