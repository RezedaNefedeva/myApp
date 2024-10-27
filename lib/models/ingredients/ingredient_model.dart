import 'package:hive/hive.dart';


part 'ingredient_model.g.dart';

@HiveType(typeId: 0)
class IngredientModel extends HiveObject{
  @HiveField(0)
  final String name;
  
  @HiveField(1)
  final String weight;
  
  @HiveField(2)
  final int price;

  IngredientModel(this.name, this.weight, this.price);

}