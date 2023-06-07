import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/products/product_list_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../screens/products/cart/cart_screen.dart';

class eProdajaDrawer extends StatelessWidget {
  
  const eProdajaDrawer({super.key});
  CartProvider? _cartProvider;

  @override
  Widget build(BuildContext context) {
    _cartProvider = context.watch<CartProvider>();
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text("Home Page"),
            onTap: () {
              Navigator.popAndPushNamed(context, ProductListScreen.routeName);
            },
          ),
          ListTile(
            title: Text("Cart ${_cartProvjder?cart.item.lenght}"),
            onTap: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
