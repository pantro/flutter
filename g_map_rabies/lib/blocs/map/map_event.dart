part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitialzedEvent extends MapEvent {
  final GoogleMapController controller;
  const OnMapInitialzedEvent(this.controller);
}

class OnStopFollowingUserMap extends MapEvent {}
class OnStartFollowingUserMap extends MapEvent {}

class OnAddHouseMap extends MapEvent {}
class OnBackHouseMap extends MapEvent {}

class OnShowVisitedHouseMap extends MapEvent {}
class OnHideVisitedHouseMap extends MapEvent {}

class OnChangeColorMarker extends MapEvent {}

class OnShowMarkersMap extends MapEvent {
  
  final Map<String, Marker> markers;

  const OnShowMarkersMap(this.markers);
}
