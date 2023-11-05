import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/blocs/blocs.dart';
import 'package:mapas_app/widgets/widgets.dart';

class ManualMarker extends StatelessWidget {
  
  const ManualMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return state.showAddHouse
        ? const _ManualMarkerBody()
        : const BtnAddHouse();
      }
    );
  }

}

class _ManualMarkerBody extends StatelessWidget {

  const _ManualMarkerBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          const Positioned(
            top: 40,
            left: 20,
            child: _BtnBack(),
          ),

          // Marcador central
          Center(
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: BounceInDown(
                from: 100,
                child: const Icon(
                  Icons.location_on_rounded, 
                  size: 50,
                )
              )
            )
          ),

          // Boton de confirmar
          Positioned(
            bottom: 50,
            left: 40,
            child: FadeInUp(
              duration: const Duration(milliseconds: 300),
              child: MaterialButton(
                minWidth: size.width-120,
                height: 40,
                color: Colors.black,
                elevation: 0,
                shape: const StadiumBorder(),
                onPressed:() {

                },
                child: const Text('Poner vivienda', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
              ),
            )
          ),
        ],
      )
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final mapBloc = BlocProvider.of<MapBloc>(context);

    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: CircleAvatar(
        maxRadius: 30,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new, 
            color: Colors.black,
          ),
          onPressed: (){
            mapBloc.add(OnBackHouseMap());
          },
        ),
      ),
    );
  }
}