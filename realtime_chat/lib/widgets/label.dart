import 'package:flutter/material.dart';

class Label extends StatelessWidget {

  final String ruta;
  final String titulo;
  final String subtitulo;

  const Label({
    Key? key,
    required this.ruta,
    required this.titulo,
    required this.subtitulo,
  }):super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(titulo, style: const TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300)),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: (){
            Navigator.pushReplacementNamed(context, ruta);
          },
          child: Text(
            subtitulo, 
            style: const TextStyle(color: Colors.blue, fontSize: 18, fontWeight: FontWeight.bold)
          )
        )
      ],
    );
  }
}