import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/mensajes_response.dart';

import 'package:realtime_chat/models/usuario.dart';
import 'package:realtime_chat/services/auth_service.dart';

class ChatService with ChangeNotifier {
  late Usuario usuarioPara;
  Future getChat(String usuarioID) async {
    final uri = Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID');
    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()
    });

    final mensajesResp = mensajesResponseFromJson(resp.body);
    return mensajesResp.msg;
  }
}
