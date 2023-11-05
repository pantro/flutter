import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/blocs/blocs.dart';

class MapView extends StatelessWidget {
  final LatLng initialLocation;
  final Set<Marker> markers;

  const MapView({
    Key? key, 
    required this.initialLocation,
    required this.markers
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    final CameraPosition initialCameraPosition =
        CameraPosition(target: initialLocation, zoom: 15.0);

    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Listener(
        onPointerMove: (pointerMoveEvent) {
          mapBloc.add(OnStopFollowingUserMap());
        },
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          compassEnabled: false, //Aprece una brujula en la parte superior izquierda
          myLocationEnabled: true, // Localizador de donde estoy actualmente
          zoomControlsEnabled: false, // Botones de zoom
          myLocationButtonEnabled: false, // Botones que aparecen que yo mismo hare despues
          markers: markers,
          onMapCreated: (controller) => mapBloc.add(OnMapInitialzedEvent(controller)),
          onCameraMove: (position) => mapBloc.mapCenter = position.target,
        ),
      ),
    );
  }
}
