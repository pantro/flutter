import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/services/auth_service.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({
    Key? key,
    required this.texto,
    required this.uid,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: uid == authService.usuario!.uid ? _myMessage() : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.only(
          top: 8,
          right: 12,
          bottom: 8,
          left: 12,
        ),
        margin: const EdgeInsets.only(
          right: 5,
          bottom: 5,
          left: 50,
        ),
        decoration: BoxDecoration(
          color: const Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          texto,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(
          top: 8,
          right: 12,
          bottom: 8,
          left: 12,
        ),
        margin: const EdgeInsets.only(
          left: 5,
          bottom: 5,
          right: 50,
        ),
        decoration: BoxDecoration(
          color: const Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(texto, style: const TextStyle(color: Colors.black87)),
      ),
    );
  }
}
