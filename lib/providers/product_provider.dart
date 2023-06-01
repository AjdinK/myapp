import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier {
  Future<dynamic> get(dynamic searchObject) async {
    return "This is test";
  }
}
