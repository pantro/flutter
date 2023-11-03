import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/blocs.dart';
import 'package:mapas_app/ui/ui.dart';

class BtnSaveLocation extends StatelessWidget {
  const BtnSaveLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationBloc = BlocProvider.of<LocationBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          iconSize: 40,
          padding: const EdgeInsets.all(0),
          icon: const Icon(
            Icons.add_location_alt_rounded,
            color: Colors.blue,
          ),
          onPressed: () {
            locationBloc.getCurrentPositionSave();

            final snack = CustomSnackBar(message: 'Se guardo la ubicacion actual');
            ScaffoldMessenger.of(context).showSnackBar(snack);
          },
        ),
      ),
    );
  }
}
