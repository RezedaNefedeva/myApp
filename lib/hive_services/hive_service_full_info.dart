import 'package:hive_flutter/hive_flutter.dart';
import 'package:production_app/exports.dart';
import 'package:production_app/hive_service.dart';

class HiveServiceFullInfo extends HiveService{

  static void addFullInfo(FullInfoProductionModel fullInfo){
    Hive.box<FullInfoProductionModel>('fullInfo').add(fullInfo);
  }

  static List<FullInfoProductionModel> getAllCompositions() {
    final result = Hive.box<FullInfoProductionModel>('fullInfo').values.toList();
    return result;
  }

  static void updateComposition(int index, FullInfoProductionModel fullInfo){
    Hive.box<FullInfoProductionModel>('fullInfo').putAt(index, fullInfo);
  }

  static void deleteComposition(int index){
    Hive.box<FullInfoProductionModel>('fullInfo').deleteAt(index);
  }
}