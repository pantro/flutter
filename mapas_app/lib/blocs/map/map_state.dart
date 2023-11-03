part of 'map_bloc.dart';

class MapState extends Equatable {
  
  final bool isMapInitialized;
  final bool isFollowingUser;

  const MapState({
    this.isFollowingUser = true,
    this.isMapInitialized = false,
  });

  MapState copyWith({
    bool? isMapInitialized,
    bool? isFollowingUser,
  }) => MapState(
    isMapInitialized: isMapInitialized ?? this.isMapInitialized,
    isFollowingUser: isFollowingUser ?? this.isFollowingUser,
  );
  
  @override
  List<Object> get props => [isMapInitialized, isFollowingUser];
}

