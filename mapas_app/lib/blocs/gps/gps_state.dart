part of 'gps_bloc.dart';

abstract class GpsState extends Equatable {
  const GpsState();

  @override
  List<Object> get props => [];
}

final class GpsInitial extends GpsState {}
