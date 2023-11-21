// To parse this JSON data, do
//
//     final mensajesResponse = mensajesResponseFromJson(jsonString);

import 'dart:convert';

MensajesResponse mensajesResponseFromJson(String str) => MensajesResponse.fromJson(json.decode(str));

String mensajesResponseToJson(MensajesResponse data) => json.encode(data.toJson());

class MensajesResponse {
    bool ok;
    List<Msg> msg;

    MensajesResponse({
        required this.ok,
        required this.msg,
    });

    factory MensajesResponse.fromJson(Map<String, dynamic> json) => MensajesResponse(
        ok: json["ok"],
        msg: List<Msg>.from(json["msg"].map((x) => Msg.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": List<dynamic>.from(msg.map((x) => x.toJson())),
    };
}

class Msg {
    String de;
    String para;
    String mensaje;
    DateTime createdAt;
    DateTime updatedAt;

    Msg({
        required this.de,
        required this.para,
        required this.mensaje,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Msg.fromJson(Map<String, dynamic> json) => Msg(
        de: json["de"],
        para: json["para"],
        mensaje: json["mensaje"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "de": de,
        "para": para,
        "mensaje": mensaje,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
