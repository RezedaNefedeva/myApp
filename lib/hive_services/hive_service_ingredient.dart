import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:production_app/exports.dart';
import 'package:production_app/hive_service.dart';

class HiveServiceIngredient extends HiveService{

  static void addIngredient(IngredientModel ingredient){
    Hive.box<IngredientModel>('ingredient').add(ingredient);
  }

  static List<IngredientModel> getAllIngredients() {
    final result = Hive.box<IngredientModel>('ingredient').values.toList();
    return result;
  }

  static void updateIngredient(int index, IngredientModel ingredient){
    Hive.box<IngredientModel>('ingredient').putAt(index, ingredient);
  }

  static void deleteIngredient(int index){
    Hive.box<IngredientModel>('ingredient').deleteAt(index);
  }

}