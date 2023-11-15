import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/login_response.dart';
import 'package:realtime_chat/models/usuario.dart';

class AuthService with ChangeNotifier {
  
  Usuario? usuario;

  Future login ( String email, String password ) async {
    //Construyendo lo que se manda por http
    final data = {
      'email': email,
      'password': password,
    };

    final uri = Uri.parse('${Environment.apiUrl}/login');

    final resp = await http.post(uri,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    print(resp.body);
    if ( resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson( resp.body );
      usuario = loginResponse.usuario;
    }
  }
}