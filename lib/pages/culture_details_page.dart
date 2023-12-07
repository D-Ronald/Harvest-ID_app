import 'package:debug_no_cell/Models/Cultura.dart';
import 'package:flutter/material.dart';

class CultureDetailsPage extends StatefulWidget {
  
  const CultureDetailsPage({super.key, required Cultura cultura});
  
  get cultura => null;

  @override
  State<CultureDetailsPage> createState() => _CultureDetailsPageState();
}

class _CultureDetailsPageState extends State<CultureDetailsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cultura.nome,)
      ),
    );
  }
}