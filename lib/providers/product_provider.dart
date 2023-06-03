import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';

class ProductProvider with ChangeNotifier {
  HttpClient client = new HttpClient();
  IOClient? http;

  ProductProvider() {
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }
  Future<dynamic> get(dynamic searchObject) async {
    var url = Uri.parse("https://10.0.2.2:7289/Proizvodi");
    var username = 'test';
    var password = 'test';
    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username:$password'))}";

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': basicAuth
    };

    var response = await http!.get(url, headers: headers);

    if (response.statusCode < 400) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('User not allowed');
    }
  }
}
