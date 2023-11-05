import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/blocs.dart';

class BtnAddHouse extends StatelessWidget {
  const BtnAddHouse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Positioned(
      top: 40,
      right: 20,
      child: FadeInRight(
        duration: const Duration(milliseconds: 300),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 25,
            child: IconButton(
              iconSize: 30,
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                Icons.add_business,
                color: Colors.blue,
              ),
              onPressed: () {
                mapBloc.add(OnAddHouseMap());
              },
            ),
          ),
        ),
      )
    );
  }
}
