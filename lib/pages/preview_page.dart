import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debug_no_cell/services/send.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:flutter/material.dart';
import 'dart:io';
class PreviewPage extends StatelessWidget {
  final File? archive;
  final String propertyId;
  final String cultureId;
  final firestore = FirebaseFirestore.instance;

  captureSucessfully(context) async {
    if (archive != null) {
      SendImage(file: archive).uploadImage(context);
    }
  }

  PreviewPage({
    Key? key,
    required this.archive,
    required this.propertyId,
    required this.cultureId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Usar Expanded para ocupar todo o espaço restante
          Expanded(
            child: Stack(
              children: [
                // A imagem agora vai ocupar toda a tela com BoxFit.contain
                Positioned.fill(
                  child: Image.file(
                    archive!,
                    fit: BoxFit.contain, // Ajuste a imagem para caber sem cortar as laterais
                    width: MediaQuery.of(context).size.width,  // Garantir largura da tela
                    height: MediaQuery.of(context).size.height, // Garantir altura da tela
                  ),
                ),
                // Botões fixos na parte inferior da tela
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.all(height(context, 2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Botão de "Check"
                        CircleAvatar(
                          radius: width(context, 8),
                          backgroundColor: blackBase.withOpacity(0.6),
                          child: IconButton(
                            icon: const Icon(Icons.check, color: whiteBase, size: 30),
                            onPressed: () => captureSucessfully(context),
                            iconSize: 60,
                          ),
                        ),
                        const SizedBox(width: 100),  // Espaçamento entre os botões
                        // Botão de "Close"
                        CircleAvatar(
                          radius: width(context, 8),
                          backgroundColor: blackBase.withOpacity(0.6),
                          child: IconButton(
                            icon: const Icon(Icons.close, color: whiteBase, size: 30),
                            onPressed: () => Navigator.of(context).pop(),
                            iconSize: 60,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
