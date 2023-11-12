import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final String text;
  final Function() onPressed;

  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 5.0,
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30.0))
      ),
      onPressed: onPressed, 
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 18),)
        ),
      )
    );
  }
}