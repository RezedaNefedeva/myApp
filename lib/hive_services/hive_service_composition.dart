import 'package:hive_flutter/hive_flutter.dart';
import 'package:production_app/exports.dart';
import 'package:production_app/hive_service.dart';

class HiveServiceComposition extends HiveService{

  static void addComposition(CompositionModel composition){
    Hive.box<CompositionModel>('composition').add(composition);
  }

  static List<CompositionModel> getAllCompositions() {
    final result = Hive.box<CompositionModel>('composition').values.toList();
    return result;
  }

  static void updateComposition(int index, CompositionModel composition){
    Hive.box<CompositionModel>('composition').putAt(index, composition);
  }

  static void deleteComposition(int index){
    Hive.box<CompositionModel>('composition').deleteAt(index);
  }
}