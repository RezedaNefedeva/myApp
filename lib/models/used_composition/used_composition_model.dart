import 'package:hive/hive.dart';
import 'package:production_app/exports.dart';

part'used_composition_model.g.dart';

@HiveType(typeId: 4)
class UsedCompositioinModel extends HiveObject{
  @HiveField(0)
  final int index;
  @HiveField(1)
  final String composition_name;
  @HiveField(2)
  final double weight;
  @HiveField(3)
  final int total;
  
  UsedCompositioinModel(this.index, this.composition_name, this.weight, this.total);
  
}