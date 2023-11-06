part of 'map_bloc.dart';

class MapState extends Equatable {
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showAddHouse;
  final bool showVisitedHouse;
  final Color colorMarker;

  final Map<String, Marker> markers;

  const MapState({
    this.isFollowingUser = true,
    this.isMapInitialized = false,
    this.showAddHouse = false,
    this.showVisitedHouse = false,
    this.colorMarker = Colors.red,
    Map<String, Marker>? markers,
  }) : markers = markers ?? const {};

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? showAddHouse,
    bool? showVisitedHouse,
    Color? colorMarker,
    Map<String, Marker>? markers,
  }) =>
      MapState(
        isMapInitialized: isMapInitialized ?? this.isMapInitialized,
        isFollowingUser: isFollowingUser ?? this.isFollowingUser,
        showAddHouse: showAddHouse ?? this.showAddHouse,
        showVisitedHouse: showVisitedHouse ?? this.showVisitedHouse,
        colorMarker: colorMarker ?? this.colorMarker,
        markers: markers ?? this.markers,
      );

  @override
  List<Object> get props =>
      [isMapInitialized, isFollowingUser, showAddHouse, showVisitedHouse, markers, colorMarker];
}
