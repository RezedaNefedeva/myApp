
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:production_app/exports.dart';
import 'package:production_app/hive_service.dart';
import 'package:production_app/widgets/products/add_product.dart';
import 'package:production_app/widgets/products/product_card.dart';

class ProductionPage extends StatefulWidget {
  const ProductionPage({super.key});

  @override
  State<ProductionPage> createState() => _ProductionPageState();
}

class _ProductionPageState extends State<ProductionPage> {

  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  List<ProductModel> product_list = <ProductModel>[];

  @override
  void initState() {
    initFirebase();
    product_list = HiveServiceProduct.getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final text_theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Продукция', style: text_theme.textTheme.bodyLarge,),
        centerTitle: true,
      ),
      floatingActionButton: const AddProduct(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
            itemCount: product_list.length,
            itemBuilder: (BuildContext context, int index){
              return ProductCard(
                  index: product_list[index].index,
                  name: product_list[index].product_name,
                  weight: product_list[index].weight,
                  price: product_list[index].product_price);
            }),
      )
    );
  }
}
