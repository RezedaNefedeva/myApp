import 'package:hive_flutter/hive_flutter.dart';
import 'package:production_app/exports.dart';
import 'package:production_app/hive_service.dart';

class HiveServiceProduct extends HiveService{

  static void addProduct(ProductModel product){
    Hive.box<ProductModel>('product').add(product);
  }

  static List<ProductModel> getAllProducts() {
    final result = Hive.box<ProductModel>('product').values.toList();
    return result;
  }

  static void updateProduct(int index, ProductModel product){
    Hive.box<ProductModel>('product').putAt(index, product);
  }

  static void deleteProduct(int index){
    Hive.box<ProductModel>('product').deleteAt(index);
  }

}