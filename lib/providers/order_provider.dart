import '../model/order.dart';
import 'base_provider.dart';

class OrderProvider extends BaseProvider<Order> {
  OrderProvider() : super("Narudzbe");

  @override
  fromJson(data) {
    // TODO: implement fromJson
    return Order();
  }
}
