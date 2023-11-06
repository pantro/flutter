import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/blocs.dart';

class BtnVisitedHouse extends StatelessWidget {
  
  const BtnVisitedHouse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return state.showVisitedHouse
        ? const _BtnVisitedHouse()
        : const SizedBox();
      }
    );
  }

}

class _BtnVisitedHouse extends StatelessWidget {
  const _BtnVisitedHouse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final mapBloc = BlocProvider.of<MapBloc>(context);

    return Positioned(
      bottom: 50,
      left: 40,
      child: FadeInUp(
        duration: const Duration(milliseconds: 300),
        child: MaterialButton(
          minWidth: size.width-120,
          height: 40,
          color: Colors.blue,
          elevation: 0,
          shape: const StadiumBorder(),
          onPressed:() async {
            mapBloc.add(OnChangeColorMarker());
          },
          child: const Text('Visitar vivienda', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
        ),
      )
    );
  }
}