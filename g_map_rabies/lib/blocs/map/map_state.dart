part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showAddHouse;

  final Map<String, Marker> markers;

  const MapState({
    this.isFollowingUser = true,
    this.isMapInitialized = false,
    this.showAddHouse = false,
    Map<String, Marker>? markers,
  }): markers = markers ?? const {};

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? showAddHouse,
    Map<String, Marker>? markers,
  }) =>
      MapState(
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
        showAddHouse: showAddHouse ?? this.showAddHouse,
        markers: markers ?? this.markers,
      );

  @override
  List<Object> get props => [isMapInitialized, isFollowingUser, showAddHouse, markers];
}
