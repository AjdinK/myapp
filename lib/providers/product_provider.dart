import 'package:myapp/providers/base_provider.dart';

import '../model/product.dart';

class ProductProvider extends BaseProvider<Product> {
  ProductProvider() : super("Proizvodi");

  @override
  Product fromJson(data) {
    //TODO : implement fromJson
    return Product.fromJson(data);
  }
}
