import 'package:debug_no_cell/Models/Cultura.dart';
import 'package:flutter/material.dart';

class CulturasDetalhesPage extends StatefulWidget {
  
  const CulturasDetalhesPage({super.key, required Cultura cultura});
  
  get cultura => null;

  @override
  State<CulturasDetalhesPage> createState() => _CulturasDetalhesPageState();
}

class _CulturasDetalhesPageState extends State<CulturasDetalhesPage>
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