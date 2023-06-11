import 'package:flutter/cupertino.dart';
import 'package:myapp/widgets/master_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product_details';
  String id;
  ProductDetailsScreen(this.id, {Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreen();
}

class _ProductDetailsScreen extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: const Center(
        child: Text("this is widget id"),
      ),
    );
  }
}
