import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

mostrarAlerta ( BuildContext context, String titulo, String subtitulo) {

  if ( Platform.isAndroid ) {
    return showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        title: Text( titulo ),
        content: Text( subtitulo ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5,
            textColor: Colors.blue,
            onPressed: () => Navigator.pop(context),
            child: const Text('Ok'),
          )
        ],
      )
    );
  }

  // Boton para IOS
  showCupertinoDialog(
    context: context, 
    builder: (_) => CupertinoAlertDialog(
      title: Text( titulo ),
      content: Text( subtitulo ),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('Ok')
        ),
      ],
    )
  );

}