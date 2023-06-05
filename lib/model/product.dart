import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';
//command to run -> flutter pub run build_runner build

@JsonSerializable()
class Product {
  int? proizvodId;
  String? naziv;
  String? slika;
  double? cijena;
  Product() {}

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
