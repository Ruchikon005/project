import 'dart:convert';

class Qr {
  final int RespCode;
  final String RespMessage;
  final String Result;

  Qr({this.RespCode, this.RespMessage, this.Result});

  Qr.fromJson(Map<String, dynamic> json)
      : RespCode = json['RespCode'],
        RespMessage = json['RespMessage'],
        Result = json['Result'];

  Map<String, dynamic> toJson() => {
        'RespCode': RespCode,
        'RespMessage': RespMessage,
        'Result': Result,
      };
}
