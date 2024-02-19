import 'package:debug_no_cell/pages/dashboard_page.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: DrawerScreen(
        setIndex: (index) {
          setState(() {
            currentIndex = index;
            
          });
        },
      ),
      mainScreen: currentScreen(),
      borderRadius: 30,
      showShadow: true,
      angle: 0.0,
      menuBackgroundColor: Color.fromARGB(255, 49, 101, 103),
    );
  }

  Widget currentScreen() {
    switch (currentIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return Container(
          color: Colors.red,
        );
      case 2:
        return Container(
          color: Colors.green,
        );
      default:
        return HomeScreen();
    }
  }
}

class HomeScreen extends StatefulWidget {
  final String title;
  const HomeScreen({super.key, this.title = 'PROPRIEDADE 1'});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text(
          'PROPRIEDADE 1',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(19, 56, 58, 1),
        shadowColor: const Color.fromRGBO(19, 56, 60, 38),
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(1),
            topRight: Radius.circular(1),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
        ),
        leading: DrawerWidget(),
      ),
    );
  }
}

class DrawerScreen extends StatefulWidget {
  final ValueSetter setIndex;
  const DrawerScreen({super.key, required this.setIndex});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 101, 103),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          drawerList(Icons.home, 'HOME', 0),
          drawerList(Icons.camera_alt, 'CAPTURAR', 1),
          drawerList(Icons.add, 'CADASTRAR', 2),
        ],
      ),
    );
  }

  Widget drawerList(IconData icon, String text, int index) {
    return GestureDetector(
      onTap: () {
        widget.setIndex(index);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, bottom: 20),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ZoomDrawer.of(context)!.toggle();
      },
      icon: const Icon(Icons.cached, color: Colors.white),
    );
  }
}
