import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription? positionStream;

  LocationBloc() : super(const LocationState()) {
    on<LocationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();

    print('+++ Position: $position');
  }

  void startFollowingUser() {
    print('startFollowingUser');
    positionStream = Geolocator.getPositionStream().listen((event) {
      final position = event;
      print('+++ Seguimiento de posicion: $position');
    });
  }

  void stopFollowingUser() {
    positionStream?.cancel();
    print('stopFollowingUser');
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
