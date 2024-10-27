

import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 3)
class ProductModel extends HiveObject{

  @HiveField(1)
  final int index;
  @HiveField(2)
  final String product_name;
  @HiveField(3)
  final double weight;
  @HiveField(4)
  final int product_price;

  ProductModel(this.index, this.product_name, this.weight, this.product_price);

}