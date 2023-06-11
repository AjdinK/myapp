import 'package:flutter/cupertino.dart';
import 'package:myapp/widgets/master_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product_details';
  String id;
  ProductDetailsScreen(this.id, {Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      child: Center(
        child: Text("Porduct id -> ${widget.id}"),
      ),
    );
  }
}
