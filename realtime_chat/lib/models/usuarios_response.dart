// To parse this JSON data, do
//
//     final usuariosResponse = usuariosResponseFromJson(jsonString);

import 'dart:convert';

import 'package:realtime_chat/models/usuario.dart';

UsuariosResponse usuariosResponseFromJson(String str) => UsuariosResponse.fromJson(json.decode(str));

String usuariosResponseToJson(UsuariosResponse data) => json.encode(data.toJson());

class UsuariosResponse {
    bool ok;
    List<Usuario> usuarios;
    String uid;

    UsuariosResponse({
        required this.ok,
        required this.usuarios,
        required this.uid,
    });

    factory UsuariosResponse.fromJson(Map<String, dynamic> json) => UsuariosResponse(
        ok: json["ok"],
        usuarios: List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromJson(x))),
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
        "uid": uid,
    };
}
