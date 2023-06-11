import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/model/product.dart';
import 'package:myapp/providers/product_provider.dart';
import 'package:myapp/screens/products/products/product_details_screen.dart';
import 'package:myapp/utils/util.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';
import '../../widgets/eprodaja_drawer.dart';
import '../../widgets/master_screen.dart';

class ProductListScreen extends StatefulWidget {
  static const String routeName = '/products';
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductProvider? _productProvider = null;
  CartProvider? _cartProvider = null;

  List<Product> data = [];
  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productProvider = context.read<ProductProvider>();
    _cartProvider = context.read<CartProvider>();

    loadData();
  }

  Future loadData() async {
    var tmpData = await _productProvider?.get(null);
    setState(
      () {
        data = tmpData! as List<Product>;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: SingleChildScrollView(
        child: Container(
          // color: Colors.redAccent,
          child: Column(
            children: [
              _buildHeader(),
              _buildProductSearch(),
              Container(
                height: 200,
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 3 / 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 0),
                  scrollDirection: Axis.horizontal,
                  children: _buildProductCardList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //  Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(),
  //     drawer: eProdajaDrawer(),
  //     body: SafeArea(
  //       child: SingleChildScrollView(
  //         child: Container(
  //           // color: Colors.redAccent,
  //           child: Column(
  //             children: [
  //               _buildHeader(),
  //               _buildProductSearch(),
  //               Container(
  //                 height: 200,
  //                 child: GridView(
  //                   gridDelegate:
  //                       const SliverGridDelegateWithFixedCrossAxisCount(
  //                           crossAxisCount: 1,
  //                           childAspectRatio: 3 / 4,
  //                           crossAxisSpacing: 10,
  //                           mainAxisSpacing: 0),
  //                   scrollDirection: Axis.horizontal,
  //                   children: _buildProductCardList(),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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

  Widget _buildProductSearch() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextField(
              controller: searchController,
              onSubmitted: (value) async {
                var tempData = await _productProvider?.get({'naziv': value});
                setState(() {
                  data = tempData!;
                });
              },
              onChanged: (value) async {
                var tempData = await _productProvider?.get({'naziv': value});
                setState(() {
                  data = tempData!;
                });
              },
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        //   child: IconButton(
        //     onPressed: () async {
        //       var tempData =
        //           await _productProvider?.get({'naziv': searchController.text});
        //       setState(() {
        //         data = tempData!;
        //       });
        //     },
        //     icon: const Icon(Icons.filter_list_outlined),
        //   ),
        // )
      ],
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
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context,
                        '${ProductDetailsScreen.routeName}/${x.proizvodId}');
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    child: imageFromBase64String(x.slika!),
                  ),
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
                  formatNumber(
                    x.cijena ?? "0",
                  ),
                  style: const TextStyle(
                      fontFamily: 'FiraMono',
                      fontSize: 14,
                      color: Colors.blueAccent),
                  overflow: TextOverflow.ellipsis,
                ),
                addVerticalSpace(2),
                TextButton(
                  onPressed: () async {
                    _cartProvider?.addToCart(x);
                  },
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.blueAccent,
                  ),
                )
              ],
            ),
          ),
        )
        .cast<Widget>()
        .toList();

    return list;
  }
}
