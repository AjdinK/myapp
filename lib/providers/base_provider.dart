import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:http/src/response.dart';
import 'package:myapp/utils/util.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  static String? _baseUrl;
  static String? _endpoint;

  HttpClient client = new HttpClient();
  IOClient? http;
  BaseProvider(String endpoint) {
    _baseUrl = const String.fromEnvironment('baseUrl',
        defaultValue: 'https://10.0.2.2:7289');
    print("baseurl: $_baseUrl");

    if (_baseUrl!.endsWith('/') == false) {
      _baseUrl = _baseUrl! + "/";
    }
    _endpoint = endpoint;
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  Future<List<T>> getById(int id, [dynamic additionalData]) async {
    var url = Uri.parse("$_baseUrl$_endpoint/$id");
    var headers = createHeaders();
    var response = await http!.get(url, headers: headers);
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return data.map((x) => fromJson(x)).cast<T>().toList();
    } else {
      throw Exception("Error with .....");
    }
  }

  Future<List<T>> get() async {
    var url = Uri.parse("$_baseUrl$_endpoint/");
    var headers = createHeaders();
    var response = await http!.get(url, headers: headers);
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return data.map((x) => fromJson(x)).cast<T>().toList();
    } else {
      throw Exception("Error with .....");
    }
  }

  Future<T?> insert(dynamic request) async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);
    Map<String, String> headers = createHeaders();
    var response =
        await http!.post(uri, headers: headers, body: jsonEncode(request));
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data) as T;
    } else {
      return null;
    }
  }

  Future<T?> update(int id, [dynamic request]) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();
    var response =
        await http!.put(uri, headers: headers, body: jsonEncode(request));
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data) as T;
    } else {
      return null;
    }
  }

  Map<String, String> createHeaders() {
    String? username = Authorization.username;
    String? password = Authorization.password;
    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username:$password'))}";
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': basicAuth
    };
    return headers;
  }

  T fromJson(data) {
    throw Exception("Override method");
  }

  bool isValidResponseCode(Response response) {
    if (response.statusCode == 200) {
      if (response.body != "") {
        return true;
      } else {
        return false;
      }
    } else if (response.statusCode == 204) {
      return false;
    } else if (response.statusCode == 400) {
      throw Exception("Bad Request");
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else if (response.statusCode == 403) {
      throw Exception("Forbidden");
    } else if (response.statusCode == 404) {
      throw Exception("Not Found");
    } else if (response.statusCode == 500) {
      throw Exception("Internal server error");
    } else {
      throw Exception("Error with Validation ....");
    }
  }
}
