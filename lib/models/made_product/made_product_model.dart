import 'package:hive/hive.dart';


part 'made_product_model.g.dart';

@HiveType(typeId: 5)
class MadeProductModel extends HiveObject{
  @HiveField(0)
  final int index;
  @HiveField(1)
  final String product_name;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final int total;

  MadeProductModel(this.index, this.product_name, this.amount, this.total);
  
}