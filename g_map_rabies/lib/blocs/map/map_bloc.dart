import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/blocs/blocs.dart';
import 'package:mapas_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;

  GoogleMapController? _mapController;

  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitialzedEvent>(_onInitMap);
    on<OnStartFollowingUserMap>(_onStartFollowingUser);
    on<OnStopFollowingUserMap>(((event, emit) => emit(state.copyWith(isFollowingUser: false))));
    
    locationStateSubscription = locationBloc.stream.listen((locationState) {
      if (!state.isFollowingUser) return; // SI no se sigue al usuario aqui no se hace nada

      if (locationState.lastKnownLocation == null) return;

      // Como ya paso los dos anteriores entonces ya se puede ejecutar este codigo
      moveCamera(locationState.lastKnownLocation!);
    });
  }

  void _onInitMap(OnMapInitialzedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;

    _mapController!.setMapStyle(jsonEncode(uberMapTheme));

    emit(state.copyWith(isMapInitialized: true));
  }

  void _onStartFollowingUser ( OnStartFollowingUserMap event, Emitter<MapState> emit){
    emit(state.copyWith(isFollowingUser: true));

    if (locationBloc.state.lastKnownLocation == null) return;
    moveCamera(locationBloc.state.lastKnownLocation!);
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
