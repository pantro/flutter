import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:csv/csv.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:path_provider/path_provider.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  
  StreamSubscription? positionStream;
  
  /*LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 1,
    );*/

  LocationBloc() : super(const LocationState()) {
    on<OnStartFollowingUser>(
        ((event, emit) => emit(state.copyWith(followingUser: true))));
    on<OnStopFollowingUser>(
        ((event, emit) => emit(state.copyWith(followingUser: false))));

    on<OnNewUserLocationEvent>((event, emit) {
      emit(state.copyWith(
        lastKnownLocation: event.newLocation,
        myLocationHistory: [...state.myLocationHistory, event.newLocation],
      ));
    });

    on<OnNewSaveLocationEvent>((event, emit) {
      emit(state.copyWith(
        myLocationSave: [...state.myLocationSave, event.newSaveLocation],
      ));
    });
  }

  Future getCurrentPosition() async {
    final position = await Geolocator.getCurrentPosition();

    add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
  }

  Future getCurrentPositionSave() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    add(OnNewSaveLocationEvent(LatLng(position.latitude, position.longitude)));
  }

  void startFollowingUser() {
    add(OnStartFollowingUser());

    positionStream = Geolocator.getPositionStream().listen((event) {
      final position = event;
      add(OnNewUserLocationEvent(
          LatLng(position.latitude, position.longitude)));
    });
  }

  void stopFollowingUser() {
    positionStream?.cancel();
    add(OnStopFollowingUser());
  }

  String generateCsv() {
    List<Map<String, dynamic>> list = [];

    for (final (index, item) in state.myLocationSave.indexed) {
      Map<String, dynamic> row = {
        "number": index,
        "lat": item.latitude,
        "lon": item.longitude,
      };
      list.add(row);
    }

    List<List<dynamic>> rows = [];
    rows.add(["number", "lat", "lon"]);

    for (var map in list) {
      rows.add([map["number"], map["lat"], map["lon"]]);
    }

    String csv = const ListToCsvConverter().convert(rows);

    return csv;
  }

  void exportCSV() async {
    String dir = (await getExternalStorageDirectory())!.path;
    String filePath = "$dir/list.csv";

    File file = File(filePath);

    String csv = generateCsv();
    await file.writeAsString(csv);
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
