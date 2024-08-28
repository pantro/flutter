import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_app/models/tarjeta_credito.dart';

part 'pagar_event.dart';
part 'pagar_state.dart';

class PagarBloc extends Bloc<PagarEvent, PagarState> {
  PagarBloc() : super(const PagarState()) {
   
    on<OnSelectTarjeta>(
      ((event, emit) => emit(
        state.copyWith(tarjetaActiva: true, tarjeta: event.tarjeta),
      )),
    );
    on<OnDesactivarTarjeta>(
      ((event, emit) => emit(
        state.copyWith(tarjetaActiva: false),
      )),
    );
  }
}