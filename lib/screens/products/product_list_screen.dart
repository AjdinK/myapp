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
  dynamic data = {};

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 100,
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 3 / 4,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 30),
                    scrollDirection: Axis.horizontal,
                    children: _buildProductCardList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildProductCardList() {
    if (data.length == 0) {
      return [const Text("Loading ....")];
    }
    List<Widget> list = data
        .map(
          (x) => Container(
            width: 100,
            height: 100,
            color: Colors.redAccent,
            child: Text(x['naziv'] ?? "NULL"),
          ),
        )
        .cast<Widget>()
        .toList();

    return list;
  }
}
