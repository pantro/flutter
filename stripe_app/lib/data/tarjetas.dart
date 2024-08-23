import '../models/tarjeta_credito.dart';

final List<TarjetaCredito> tarjetas = <TarjetaCredito>[
  TarjetaCredito(
    cardNumberHidden: '4242', 
    cardNumber: '42424242', 
    brand: 'visa', 
    cvv: '213', 
    expiracyDate: '01/25', 
    cardHolderName: 'Fernando'
  ),
  TarjetaCredito(
    cardNumberHidden: '1212', 
    cardNumber: '12121212', 
    brand: 'mastercard', 
    cvv: '122', 
    expiracyDate: '03/26', 
    cardHolderName: 'Gian Luna'
  )
];