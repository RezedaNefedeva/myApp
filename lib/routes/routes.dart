import 'package:production_app/exports.dart';
import 'package:production_app/pages/components_page.dart';

final routes = {
  '/' : (context) => const MainPage(),
  '/ingredients' : (context) => const IngredientsPage(),
  '/product_composition' : (context) => const ProductCompositionPage(),
  '/production' : (context) => const ProductionPage(),
  '/reports' : (context) => const ReportsPage(),
  '/made' : (context) => const MadePage(),
  '/components' : (context) => const ComponentsPage(),
};