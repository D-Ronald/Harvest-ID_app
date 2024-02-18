import 'package:debug_no_cell/pages/ReadData/hidden_drawer.dart';
import 'package:debug_no_cell/pages/cadaster_property_page.dart';
import 'package:debug_no_cell/pages/capture_page.dart';
import 'package:debug_no_cell/pages/dashboard_page.dart';
import 'package:debug_no_cell/pages/profile_page.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:debug_no_cell/pages/home_page.dart';
import 'package:flutter/material.dart';

class ViewPage extends StatelessWidget {
  const ViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    //Intanciando o controlador das páginas
    PageController page_controller = PageController();
    return Scaffold(
        body: PageView(
          controller: page_controller,
          //lista com as páginas que se relacionam diretamente com os ícones da barra de navegação
          children: [
            HomePage(),
            CapturePage(),
            CadasterProperty_page(),
            DashboardPage(),
            HiddenDrawer()
          ],
        ),
        bottomNavigationBar: navigationBar(
            pageController: page_controller,
            backgroundColor: mediumGrayBase,
            iconColor: darkGrayBase));
  }
}
