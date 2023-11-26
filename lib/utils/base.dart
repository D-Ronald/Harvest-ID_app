import 'dart:ui';
import 'package:flutter/material.dart';

const darkGreenBase = Color.fromRGBO(19, 56, 58, 1);
const dark_gray_base = Color.fromRGBO(62, 68, 69, 1);
const ligth_gray_base = Color.fromRGBO(217, 217, 217, 1);
const white_base = Color.fromRGBO(255, 255, 255, 1);
const black_base = Color.fromRGBO(0, 0, 0, 1);
const blue_base = Color.fromRGBO(1, 96, 113, 1);
const transpartent = Color.fromRGBO(255, 255, 255, 0);

///Recebe um contexto atual da aplicação e um inteiro entre 0 e 100
///e o transforma em uma altura proporcional a altura da tela de qualquer dipositivo
double height(context, int percentage) {
  return (MediaQuery.of(context).size.height) * (percentage / 100);
}

///Recebe um contexto atual da aplicação e um inteiro entre 0 e 100
///e o transforma em uma largura proporcional a largura da tela de qualquer dipositivo
double width(context, widthPercentage) {
  return (MediaQuery.of(context).size.width) * (widthPercentage / 100);
}

///Recebe um contexto atual da aplicação e um inteiro entre 0 e 100
///e gera um espaço vazio vertical entre componentes
///sempre o aplique quando quiser espaçar verticalmente os componentes
Container spacing(context, int heightPercentage) {
  return Container(
    height: height(context, heightPercentage),
  );
}

ElevatedButton genericButton(context, backgroundColor, textColor, String text,
    int percentageHeight, int percentageWidth, function) {
  return ElevatedButton(
    onPressed: () {
      function();
    },
    child: Text(
      text,
      style: TextStyle(
        color: textColor,
        fontSize: 20,
      ),
    ),
    style: ElevatedButton.styleFrom(
      primary: backgroundColor,
      minimumSize: Size(
          width(context, percentageWidth), height(context, percentageHeight)),
    ),
  );
}

ElevatedButton genericButtonIcon(
    context,
    backgroundColor,
    textColor,
    String text,
    Icon icon,
    int percentageHeight,
    int percentageWidth,
    function) {
  return ElevatedButton(
      onPressed: () {
        function();
      },
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        minimumSize: Size(
            width(context, percentageWidth), height(context, percentageHeight)),
      ),
      child: Container(
          width: width(context, percentageWidth),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            icon,
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
              ),
            ),
          ])));
}

Container genericTextButton({
  required context,
  required String text,
  required double textSize,
  required textColor,
  required double padding,
  required function,
}) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: TextButton(
          onPressed: () {
            function();
          },
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: textSize,
            ),
          )));
}

///A função retorna uma caixa de entradatexto na qual o objeto do tipo [TextEditingController]
/// receberá o texto de entrada e o armazenará para que possa ser usado posteriormente.
Container genericTextFormPassword(
    {required context,
    required TextEditingController controller,
    required String labeltext,
    required labelColor,
    required int heightPercentage,
    required double padding,
    required color,
    required backgroundColor,
    required double borderRadius}) {
  return Container(
      height: height(context, heightPercentage),
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: 0.00),
      child: TextField(
        obscureText: false,
        keyboardType: TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          fillColor: backgroundColor,
          filled: true,
          hintText: labeltext,
          hintMaxLines: 1,
          hintStyle: TextStyle(
            color: labelColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(
          color: color,
        ),
      ));
}

///Adiciona uma imagem
Container genericBigImage(
    {required context,
    required String src,
    required int heightPercentage,
    required int widthPercentage}) {
  return Container(
    child: new Image.asset(
      src,
      height: height(context, heightPercentage),
    ),
  );
}

///Adiciona uma imagem ao final de um linha, geralmente usad para icones pequenos alinhados ao contos de tela.
Row imageButtonRowEnd({
  required context,
  required String src,
  required int heightPercentage,
  required int widthPercentage,
  required function,
  required backgroundColor,
}) {
  return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
    ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
        onPressed: () {
          function();
        },
        child: new Image.asset(
          src,
          height: height(context, heightPercentage),
          width: width(context, widthPercentage),
        ))
  ]);
}

///Função que retorna uma barra de navegação para que haja naveguação entre as páginas
BottomNavigationBar navigationBar(
    {required PageController pageController,
    required backgroundColor,
    required iconColor}) 
    {
  return BottomNavigationBar(
    backgroundColor: backgroundColor,
    onTap: (int page) {
      pageController.jumpToPage(page);
    },
    //Lista a qual se relaciona com as páginas. aqui são colocados os ícones que irão compor a barra
    items: [
      //Icone de home
      BottomNavigationBarItem(
        icon: Icon(Icons.home, color: iconColor),
        label: "",
      ),
      //Icone de lupa
      BottomNavigationBarItem(
        icon: Icon(Icons.search, color: iconColor),
        label: "",
      ),
      //Icone de adicionar
      BottomNavigationBarItem(
        icon: Icon(Icons.add, color: iconColor),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.dashboard, color: iconColor),
        label: "",
      ),
      //Icone de perfil
      BottomNavigationBarItem(
        icon: Icon(Icons.person, color: iconColor),
        label: "",
      ),
    ],
  );
}