import 'package:debug_no_cell/services/send.dart';
import 'package:debug_no_cell/utils/base.dart';
import 'package:debug_no_cell/utils/routes.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart';

class PreviewPage extends StatelessWidget {
  File? archive;

  captureSucessfully(context) {
    if (archive != null) SendImage(file: archive).sendImage(context);
  }

  PreviewPage({
    Key? key,
    this.archive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: Stack(
            children: [
              Positioned.fill(
                  child: Image.file(
                archive!,
                fit: BoxFit.cover,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(height(context, 8)),
                        child: CircleAvatar(
                            radius: width(context, 8),
                            backgroundColor: blackBase.withOpacity(0.6),
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.check,
                                    color: whiteBase, size: 30),
                                onPressed: () => captureSucessfully(context),
                                iconSize: 60,
                              ),
                            )),
                      )),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(height(context, 8)),
                        child: CircleAvatar(
                            radius: width(context, 8),
                            backgroundColor: blackBase.withOpacity(0.6),
                            child: Center(
                              child: IconButton(
                                icon: Icon(Icons.close,
                                    color: whiteBase, size: 30),
                                onPressed: () => Navigator.of(context).pop(),
                                iconSize: 60,
                              ),
                            )),
                      ))
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
