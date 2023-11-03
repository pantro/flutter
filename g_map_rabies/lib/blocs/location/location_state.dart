part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? lastKnownLocation;
  final List<LatLng> myLocationHistory;
  final List<LatLng> myLocationSave;

  const LocationState({
    this.followingUser = false, 
    this.lastKnownLocation, 
    myLocationHistory,
    myLocationSave
    }): myLocationHistory = myLocationHistory ?? const [],
    myLocationSave = myLocationSave ?? const [];

  LocationState copyWith({
    bool? followingUser,
    LatLng? lastKnownLocation,
    List<LatLng>? myLocationHistory,
    List<LatLng>? myLocationSave,
  }) => LocationState(
    followingUser: followingUser ?? this.followingUser,
    lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
    myLocationHistory: myLocationHistory ?? this.myLocationHistory,
    myLocationSave: myLocationSave ?? this.myLocationSave,
  );
  
  @override
  List<Object?> get props =>
      [followingUser, lastKnownLocation, myLocationHistory, myLocationSave];
}
