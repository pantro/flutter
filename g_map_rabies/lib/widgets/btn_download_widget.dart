import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/blocs.dart';
import 'package:mapas_app/ui/ui.dart';

class BtnDownload extends StatelessWidget {
  const BtnDownload({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          iconSize: 30,
          padding: const EdgeInsets.all(0),
          icon: const Icon(
            Icons.download,
            color: Colors.blue,
          ),
          onPressed: () {
            locationBloc.exportCSV();

            final snack = CustomSnackBar(message: 'Se descargo el archivo con exito.');
            ScaffoldMessenger.of(context).showSnackBar(snack);
          },
        ),
      ),
    );
  }
}
