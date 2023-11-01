part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? lastKnownLocation;
  final List<LatLng> myLocationHistory;

  const LocationState(
      {this.followingUser = false, this.lastKnownLocation, myLocationHistory})
      : myLocationHistory = myLocationHistory ?? const [];

  @override
  List<Object?> get props =>
      [followingUser, lastKnownLocation, myLocationHistory];
}
