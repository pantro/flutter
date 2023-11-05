part of 'map_bloc.dart';

class MapState extends Equatable {
  
  final bool isMapInitialized;
  final bool isFollowingUser;
  final bool showAddHouse;

  const MapState({
    this.isFollowingUser = true,
    this.isMapInitialized = false,
    this.showAddHouse = false,
  });

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
    bool? showAddHouse,
  }) => MapState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    isFollowingUser: isFollowingUser ?? this.isFollowingUser,
    showAddHouse: showAddHouse ?? this.showAddHouse,
  );
  
  @override
  List<Object> get props => [isMapInitialized, isFollowingUser, showAddHouse];
}

