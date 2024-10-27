

import 'package:hive/hive.dart';
import 'package:production_app/models/composition_ingredient/composition_ingredient_model.dart';

part 'composition_model.g.dart';

@HiveType(typeId: 1)
class CompositionModel extends HiveObject{
  
  @HiveField(0)
  final String title;
  @HiveField(1)
  final List<CompositionIngredientModel> list;
  @HiveField(2)
  final int total;


  CompositionModel(this.title, this.list, this.total);
}