part of 'pagar_bloc.dart';

class PagarState extends Equatable {
  final double montoPagar;
  final String moneda;
  final bool tarjetaActiva;
  final TarjetaCredito? tarjeta;

  const PagarState({
    this.montoPagar = 375.66,
    this.moneda = 'MX',
    this.tarjetaActiva = false,
    this.tarjeta
  });

  PagarState copyWith({
    double? montoPagar,
    String? moneda,
    bool? tarjetaActiva,
    TarjetaCredito? tarjeta,
  }) => PagarState(
    moneda: moneda ?? this.moneda,
    montoPagar: montoPagar ?? this.montoPagar,
    tarjeta: tarjeta ?? this.tarjeta,
    tarjetaActiva: tarjetaActiva ?? this.tarjetaActiva
  );

  @override
  List<Object?> get props => [moneda, montoPagar, tarjetaActiva, tarjeta];
}