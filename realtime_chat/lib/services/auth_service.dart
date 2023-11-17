import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:realtime_chat/global/environment.dart';
import 'package:realtime_chat/models/login_response.dart';
import 'package:realtime_chat/models/usuario.dart';

class AuthService with ChangeNotifier {
  
  Usuario? usuario;
  bool _autenticando = false;

  final _storage = const FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando ( bool valor ) {
    _autenticando = valor;
    notifyListeners();
  }

  // Getters del token de forma estatica, para poder accederlo desde cualquier lado del app
  static Future getToken() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    return token;
  }
  static Future<void> deleteToken() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  Future<bool> login ( String email, String password ) async {

    autenticando = true;

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

    autenticando = false;//Desbloqueando el boton de ingreso de login
    
    if ( resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson( resp.body );
      
      usuario = loginResponse.usuario;
      
      await _guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future register ( String nombre, String email, String password ) async {

    autenticando = true;//Va a modificar a los listener que estan escuchando para actualizar alguna pantalla

    //Construyendo lo que se manda por http
    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
    };
    final uri = Uri.parse('${Environment.apiUrl}/login/new');

    final resp = await http.post(uri,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    autenticando = false;//Desbloqueando el boton de ingreso de login
    
    if ( resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson( resp.body );
      usuario = loginResponse.usuario;
      await _guardarToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody;
    }
  }

  Future _guardarToken (String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    // Eliminar token
    await _storage.delete(key: 'token');
  }
}