import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:stripe_app/data/tarjetas.dart';
import 'package:stripe_app/helpers/helpers.dart';
import 'package:stripe_app/pages/tarjeta_page.dart';
import 'package:stripe_app/widgets/total_pago_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context){

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagar'),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: const Icon(Icons.add)),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            width: size.width,
            height: size.height,
            top: 200,
            child: PageView.builder(
              controller: PageController(
                viewportFraction: 0.9
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: tarjetas.length,
              itemBuilder: (_, i){

                final tarjeta = tarjetas[i];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, navegarFadeIn(context, TarjetaPage()));
                  },
                  child: Hero(
                    tag: tarjeta.cardNumber,
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
                );
              }
            )
          ),
          const Positioned(
            bottom: 0,
            child: TotalPagoButton(),
          )
        ],
      )
    );
  }
}