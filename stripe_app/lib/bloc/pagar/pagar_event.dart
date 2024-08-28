part of 'pagar_bloc.dart';

abstract class PagarEvent extends Equatable {
  const PagarEvent();
  
  @override
  List<Object> get props => [];
}

class OnSelectTarjeta extends PagarEvent{
  final TarjetaCredito? tarjeta;
  
  const OnSelectTarjeta({ this.tarjeta });
}

class OnDesactivarTarjeta extends PagarEvent{}
