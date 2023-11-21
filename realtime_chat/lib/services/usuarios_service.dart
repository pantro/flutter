import 'package:http/http.dart' as http;
import 'package:realtime_chat/global/environment.dart';

import 'package:realtime_chat/models/usuario.dart';
import 'package:realtime_chat/models/usuarios_response.dart';
import 'package:realtime_chat/services/auth_service.dart';

class UsuariosService {

  // Otra forma de obtener los resultados de backend
  Future<List<Usuario>> getUsuarios() async {

    try {
      final uri = Uri.parse('${Environment.apiUrl}/usuarios');

      final resp = await http.get(uri, 
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        }
      );

      final usuariosResponse = usuariosResponseFromJson(resp.body);
      return usuariosResponse.usuarios;

    } catch (e) {
      return [];
    }

  }
}