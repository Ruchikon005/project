import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:khnomapp/action/generateQr.dart';
import 'package:khnomapp/action/get_profileprefs.dart';
import 'package:khnomapp/model/profile_model.dart';
import 'package:khnomapp/model/qr_model.dart';
import 'dart:convert' as convert;

class GenQr extends StatefulWidget {
  final String amount;
  const GenQr(this.amount, {Key key}) : super(key: key);
  @override
  _GenQrState createState() => _GenQrState();
}

class _GenQrState extends State<GenQr> {
  Profile profile = Profile();
  Uint8List _bytesImage;
  Qr qrPrompt = Qr();
  File decodedimgfile;
  String decodedpath;

  Future genQrPrompt() async {
    profile = await getProfile();
    var qr0 = await generatePrompt(profile.user_id, widget.amount);
    qrPrompt = Qr.fromJson(qr0);
    print(qrPrompt.Result);
    setState(() async {
      _bytesImage =  base64Decode('iVBORw0KGgoAAAANSUhEUgAAAKQAAACkCAYAAAAZtYVBAAAAAklEQVR4AewaftIAAAYOSURBVO3BQY4cy5LAQDJQ978yR0tfJVDIbr3QHzezP1jrEoe1LnJY6yKHtS5yWOsih7UucljrIoe1LnJY6yKHtS5yWOsih7UucljrIoe1LnJY6yKHtS7y4SWVv6liUpkqJpU3KiaVqeKJypOKN1Smiknlb6p447DWRQ5rXeSw1kU+/LCKn6TypGJS+UkqU8WkMlU8qZhUporfVPGTVH7SYa2LHNa6yGGti3z4ZSrfqHijYlKZKiaVqWJS+YbKE5WpYlL5RsUbKt+o+E2HtS5yWOsih7Uu8uEfpzJVTBWTylTxpGJS+UbFNyqeqPwvO6x1kcNaFzmsdZEP/8+pPKmYKiaVb6hMFU9UnqhMFf+yw1oXOax1kcNaF/nwyypuVjGpPFGZKiaVSWWqmFSmiqliUpkq3qi4yWGtixzWushhrYt8+GEqN1GZKiaVqWJSmSomlaliUnlDZaqYVKaKJyo3O6x1kcNaFzmsdRH7g3+YyhsVk8pU8Q2VqWJSeaPif9lhrYsc1rrIYa2LfHhJZar4hspUMal8o2JSmSqeVEwqTyq+UfGGylQxqfykiicqU8Ubh7UucljrIoe1LmJ/8BepTBV/k8pU8URlqniiMlVMKlPFGypTxROVJxWTylTxmw5rXeSw1kUOa13kww9TmSreUHlS8URlqphU3lCZKiaV31QxqUwVTypucljrIoe1LnJY6yIfXlJ5ovJE5UnFE5UnFU8qJpWpYlL5RsWk8kTlGxU/SWWq+JsOa13ksNZFDmtd5MNLFd9QeVIxqTypeEPlJhWTylQxqUwV31CZKp6oPKl447DWRQ5rXeSw1kXsD36QypOKJypTxROVqWJSmSqeqDyp+IbKNyq+ofKk4onKVDGpfKPijcNaFzmsdZHDWhf58JLKVDGpfKNiUvlJKk8qnqhMFd+omFQmlScVTyqeqDxReVLxmw5rXeSw1kUOa13E/uAHqbxR8URlqphUnlRMKlPFpPJGxTdUnlS8ofJGxW86rHWRw1oXOax1kQ8vqTyp+IbKGxWTyqTyRsUbKt+o+IbKVPGk4onKpPKk4o3DWhc5rHWRw1oX+fAfU3lSMalMKt+omFR+k8pvUnmi8g2V/9JhrYsc1rrIYa2LfPhhFd+oeKIyVUwq31D5RsUTlScVT1SeqDypmFR+UsXfdFjrIoe1LnJY6yIf/mMqTyp+UsUbKlPFpDKp/KSKJxVPVCaVN1SmijcOa13ksNZFDmtd5MNLFZPKVPGNikllqpgqJpWpYlKZKiaVqeIbFZPKVDGpTBVPVJ5UTCpTxaQyVUwqf9NhrYsc1rrIYa2LfHhJZap4ojJVPKl4ovKNikllqphUpopJZaqYKiaVqWJSmSqmiicq/7LDWhc5rHWRw1oX+fBSxROVN1SeVDxRmSpuVjGpPKmYKt5QeVLxmw5rXeSw1kUOa13kw39MZaqYKn5TxZOKJxVPVJ6o/CSVqeKNikllqvhJh7UucljrIoe1LmJ/8ILKNyq+oTJVPFGZKiaVJxVPVJ5UTCpTxaQyVUwqf1PFN1SmijcOa13ksNZFDmtdxP7gH6YyVfwklScVk8qTiicqTyomlaniGypTxX/psNZFDmtd5LDWRT68pPI3VXxD5UnFT6qYVL5R8UTlGypTxROVb1T8pMNaFzmsdZHDWhf58MMqfpLKk4pJZap4ojJVTBWTyqQyVUwVb6hMFZPKk4o3Kv6mw1oXOax1kcNaF/nwy1S+UfENlTcqJpV/mcpvUpkqftJhrYsc1rrIYa2LfPjHVUwqT1SeVEwqU8UTlTcqporfVDGpfENlqnjjsNZFDmtd5LDWRT78j1OZKiaVJxWTylQxVUwqU8WkMql8o+IbKpPKE5Wp4jcd1rrIYa2LHNa6yIdfVvFfqphUnqh8Q+WNiknlScUbFZPKVPFEZar4SYe1LnJY6yKHtS5if/CCyt9UMam8UTGpPKmYVH5TxROVNyqeqHyj4o3DWhc5rHWRw1oXsT9Y6xKHtS5yWOsih7UucljrIoe1LnJY6yKHtS5yWOsih7UucljrIoe1LnJY6yKHtS5yWOsih7Uu8n+npellAOdiDwAAAABJRU5ErkJggg==');
      // decodedimgfile = await File("image.jpg").writeAsBytes(_bytesImage);
      // decodedpath = decodedimgfile.path;
      // print('$decodedpath +++++');
    });
    return qrPrompt.Result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: genQrPrompt(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Image.memory(_bytesImage),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
