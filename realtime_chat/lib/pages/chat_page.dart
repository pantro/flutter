import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realtime_chat/widgets/widgets.dart';

class ChatPage extends StatefulWidget {
  
  const ChatPage({super.key});
  
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

  final _textController = TextEditingController();
  final _focusNode = FocusNode();

  final List<ChatMessage> _messages = [];

  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.blue,
              maxRadius: 14,
              child: Text('Te', style: TextStyle(fontSize: 12),),
            ),
            SizedBox(height: 3),
            Text('Melisa Paredes', style: TextStyle(color: Colors.black87, fontSize: 12),)
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (_,i) => _messages[i],
              reverse: true,
            )
          ),
          const Divider(height: 1,),
          Container(
            color: Colors.white,
            height: 80,
            child: _inputChat(),
          )
        ]
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String texto){
                  setState(() {
                    if (texto.trim().isNotEmpty){
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration: const InputDecoration.collapsed(hintText: 'Enviar mensaje'),
                focusNode: _focusNode,
              )
            ),

            //Boton enviar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS 
                ? CupertinoButton(
                  onPressed: _estaEscribiendo
                        ? ()=> _handleSubmit(_textController.text.trim())
                        : null,
                  child: const Text('Enviar'), 
                )
                : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  child: IconTheme(
                    data: const IconThemeData(color: Colors.blue),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: const Icon(Icons.send),
                      onPressed: _estaEscribiendo
                        ? ()=> _handleSubmit(_textController.text.trim())
                        : null,
                    ),
                  )
                ),
            )
          ],
        ),
      )
    );
  }

  _handleSubmit(String texto){

    if (texto.isEmpty) return;
    
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      texto: texto, 
      uid: '123',
      animationController: AnimationController(vsync: this, duration: const Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    //Disparar la animacion
    newMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });

    //Para limpiar el animation
    @override
    void dispose() {
      for(ChatMessage message in _messages) {
        message.animationController.dispose();
      }

      super.dispose();
    }
  }
}
