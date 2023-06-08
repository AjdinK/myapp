import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../screens/products/cart/cart_screen.dart';
import '../screens/products/product_list_screen.dart';

class eProdajaDrawer extends StatelessWidget {
  eProdajaDrawer({Key? key}) : super(key: key);
  CartProvider? _cartProvider;
  @override
  Widget build(BuildContext context) {
    _cartProvider = context.watch<CartProvider>();
    print("called build drawer");
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Home page'),
            onTap: () {
              Navigator.popAndPushNamed(context, ProductListScreen.routeName);
            },
          ),
          ListTile(
            title: Text('Cart ${_cartProvider?.cart.items.length}'),
            onTap: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
