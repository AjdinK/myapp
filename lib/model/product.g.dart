// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product()
  ..proizvodId = json['proizvodId'] as int?
  ..naziv = json['naziv'] as String?
  ..slika = json['slika'] as String?
  ..cijena = (json['cijena'] as num?)?.toDouble();

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'proizvodId': instance.proizvodId,
      'naziv': instance.naziv,
      'slika': instance.slika,
      'cijena': instance.cijena,
    };
