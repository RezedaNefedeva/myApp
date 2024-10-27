import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:production_app/exports.dart';

export 'hive_services/hive_service_ingredient.dart';
export 'hive_services/hive_service_composition.dart';
export 'hive_services/hive_service_product.dart';

class HiveService {

  static initHive() async{
    final applicationDocumentDir =
      await path_provider.getApplicationDocumentsDirectory();

    await Hive
      ..init(applicationDocumentDir.path)
      ..registerAdapter(IngredientModelAdapter())
      ..registerAdapter(CompositionModelAdapter())
      ..registerAdapter(CompositionIngredientModelAdapter())
      ..registerAdapter(ProductModelAdapter())
      ..registerAdapter(UsedCompositioinModelAdapter())
      ..registerAdapter(MadeProductModelAdapter())
      ..registerAdapter(FullInfoProductionModelAdapter());


    await Hive.openBox<IngredientModel>('ingredient');
    await Hive.openBox<CompositionModel>('composition');
    await Hive.openBox<ProductModel>('product');
    await Hive.openBox<FullInfoProductionModel>('fullInfo');

  }
}