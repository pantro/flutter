import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/blocs.dart';

class BtnToggleRoute extends StatelessWidget {
  const BtnToggleRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          onPressed: () {
            mapBloc.add(OnToggleRoute());
          },
          icon: const Icon(
            Icons.more_horiz_rounded,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
