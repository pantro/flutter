import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/blocs/blocs.dart';
import 'package:mapas_app/helpers/helpers.dart';
import 'package:mapas_app/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;

  GoogleMapController? _mapController;

  LatLng? mapCenter;

  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitialzedEvent>(_onInitMap);
    on<OnStartFollowingUserMap>(_onStartFollowingUser);
    on<OnStopFollowingUserMap>(
        ((event, emit) => emit(state.copyWith(isFollowingUser: false))));

    on<OnAddHouseMap>(
        (event, emit) => emit(state.copyWith(showAddHouse: true)));
    on<OnBackHouseMap>(
        (event, emit) => emit(state.copyWith(showAddHouse: false)));

    on<OnShowVisitedHouseMap>(
        (event, emit) => emit(state.copyWith(showVisitedHouse: true, showAddHouse: false)));
    on<OnHideVisitedHouseMap>(
        (event, emit) => emit(state.copyWith(showVisitedHouse: false)));

    on<OnChangeColorMarker>(_onChangeColorMarker);

    on<OnShowMarkersMap>(
        (event, emit) => emit(state.copyWith(markers: event.markers)));

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

  void _onStartFollowingUser(
      OnStartFollowingUserMap event, Emitter<MapState> emit) {
    emit(state.copyWith(isFollowingUser: true));

    if (locationBloc.state.lastKnownLocation == null) return;
    moveCamera(locationBloc.state.lastKnownLocation!);
  }

  void _onChangeColorMarker(OnChangeColorMarker event, Emitter<MapState> emit) {
    
    if (state.colorMarker == Colors.red) {
      emit(state.copyWith(colorMarker: Colors.yellow));
    } else if (state.colorMarker == Colors.yellow) {
      emit(state.copyWith(colorMarker: Colors.green));
    }
    
    updateMarkers();
    add(OnHideVisitedHouseMap());
    
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  Future drawMarkers(LatLng position) async {
    final newId = state.markers.length;

    final iconMarker = await getCustomMarker(state.colorMarker);

    final marker = Marker(
        markerId: MarkerId('ID_$newId'),
        position: position,
        icon: iconMarker,
        infoWindow: InfoWindow(
          title: 'ID $newId',
        ),
        onTap: () {
          add(OnShowVisitedHouseMap());
        });

    final currentMarkers = Map<String, Marker>.from(
        state.markers); // Realizando una copia de lo que se tiene
    currentMarkers['ID_$newId'] = marker;

    add(OnShowMarkersMap(currentMarkers));
  }

  void updateMarkers() async {
    final iconMarker = await getCustomMarker(state.colorMarker);
    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers.forEach((key, value) {
      final markerUpdate = Marker(
        markerId: value.markerId,
        position: value.position,
        icon: iconMarker,
        infoWindow: InfoWindow(
          title: key,
        ),
        onTap: () {
          add(OnShowVisitedHouseMap());
        });
        currentMarkers[key] = markerUpdate;
    });
    
    add(OnShowMarkersMap(currentMarkers));
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
