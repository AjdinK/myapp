import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/model/product.dart';
import 'package:myapp/providers/product_provider.dart';
import 'package:myapp/utils/util.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  static const String routeName = '/products';
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  var f = NumberFormat("###.0#");
  ProductProvider? _productProvider = null;
  List<Product> data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productProvider = context.read<ProductProvider>();
    loadData();
  }

  Future loadData() async {
    var tmpData = await _productProvider?.get();
    setState(
      () {
        data = tmpData! as List<Product>;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            // color: Colors.redAccent,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                _buildHeader(),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 150,
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

  Widget _buildHeader() {
    return Container(
      child: const Text(
        "Products",
        style: TextStyle(
            fontFamily: 'FiraMono',
            color: Colors.blueAccent,
            fontSize: 40,
            fontWeight: FontWeight.bold),
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
            width: 200,
            height: 200,
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  child: imageFromBase64String(x.slika!),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  x.naziv ?? "NULL",
                  style: const TextStyle(
                      fontFamily: 'FiraMono',
                      fontSize: 11,
                      color: Colors.black87),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  f.format(
                    x.cijena ?? "0",
                  ),
                  style: const TextStyle(
                      fontFamily: 'FiraMono',
                      fontSize: 14,
                      color: Colors.blueAccent),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        )
        .cast<Widget>()
        .toList();

    return list;
  }
}
