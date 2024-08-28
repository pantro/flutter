import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stripe_app/bloc/pagar/pagar_bloc.dart';
import 'package:stripe_app/widgets/total_pago_button.dart';

class TarjetaPage extends StatelessWidget {
  
  const TarjetaPage({super.key});

  @override
  Widget build(BuildContext context){

    final tarjeta = context.read<PagarBloc>().state.tarjeta;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Regresar a Pagar'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<PagarBloc>().add( OnDesactivarTarjeta() );//Otra forma de acceder a los bloc
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(),
          Hero(
            tag: tarjeta!.cardNumber,
            child: CreditCardWidget(
              isSwipeGestureEnabled: false,
              isHolderNameVisible: true,
              cardNumber: tarjeta.cardNumberHidden, 
              expiryDate: tarjeta.expiracyDate, 
              cardHolderName: tarjeta.cardHolderName, 
              cvvCode: tarjeta.cvv, 
              showBackView: false, 
              onCreditCardWidgetChange: (CreditCardBrand brand) {},
            ),
          ),
          const Positioned(
            bottom: 0,
            child: TotalPagoButton()
          ),
        ],
      )
    );
  }
}