import 'package:debug_no_cell/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _properties = [];
  final textStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();

    _properties = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
            name: 'PROPRIEDADE',
            baseStyle: textStyle,
            selectedStyle: textStyle,
            colorLineSelected: const Color.fromARGB(19, 56, 58, 1),
            
          ),
        const ProfilePage(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return 
    HiddenDrawerMenu(
        screens: _properties,
        initPositionSelected: 0,
        backgroundColorMenu: const Color.fromRGBO(16, 56, 58, 100),
        slidePercent: 60,
        );
  }
}
