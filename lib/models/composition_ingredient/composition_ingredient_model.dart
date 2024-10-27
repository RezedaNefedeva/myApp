import 'package:hive/hive.dart';

part 'composition_ingredient_model.g.dart';

@HiveType(typeId: 2)
class CompositionIngredientModel{
  @HiveField(0)
  final int index;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final int total_price;

  CompositionIngredientModel(this.index, this.name, this.amount, this.total_price);

}