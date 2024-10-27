import 'package:hive/hive.dart';
import 'package:production_app/exports.dart';

part 'full_info_production_model.g.dart';

@HiveType(typeId: 6)
class FullInfoProductionModel extends HiveObject{
  @HiveField(0)
  final DateTime dateTime;
  @HiveField(1)
  final List<UsedCompositioinModel> composition_list;
  @HiveField(2)
  final List<MadeProductModel> products_list;
  @HiveField(3)
  final int work_price;
  @HiveField(4)
  final int spend;
  @HiveField(5)
  final int total;
  @HiveField(6)
  final int finance;
  @HiveField(7)
  final double kg;
  
  FullInfoProductionModel(this.dateTime, this.composition_list, this.products_list, this.work_price, this.spend, this.total, this.finance, this.kg);

}