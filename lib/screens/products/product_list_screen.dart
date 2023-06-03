import 'package:flutter/material.dart';
import 'package:myapp/providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  static const String routeName = '/products';
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductProvider? _productProvider = null;
  String data = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productProvider = context.read<ProductProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _productProvider?.get(null);
    setState(
      () {
        data = tmpData;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(data),
      ),
    );
  }
}
