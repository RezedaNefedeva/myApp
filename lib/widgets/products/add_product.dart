
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:production_app/exports.dart';
import 'package:production_app/hive_service.dart';
import 'package:production_app/widgets/ingredients/alerd_dialog_add_ingredient.dart';
import 'package:production_app/widgets/products/alert_dialog_add_product.dart';

import '../dark_btn.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  List<ProductModel> product_list = <ProductModel> [];

  @override
  void initState() {
    initFirebase();
    product_list = HiveServiceProduct.getAllProducts();
    super.initState();
  }

  final TextEditingController product_title_controller = TextEditingController();
  final TextEditingController product_weight_controller = TextEditingController();
  final TextEditingController product_price_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final text_theme = Theme.of(context);

    int price = product_price_controller.text.isEmpty?0:int.parse(product_price_controller.text);
    return Container(
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: <Color>[
          Color(0xff7365A2),
          Color(0xff70426A),
          Color(0xffEA6D79),
          Color(0xffFDA187),
        ],
            begin: Alignment.topLeft,
            end: Alignment(1.5, 1)
        ),
      ),
      child:
      FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: (){
          showDialog(
              context: context,
              builder: (context){
                return AlerdDialogAddProduct(
                    index: product_list.length+1,
                    product_title_controller: product_title_controller,
                    product_weight_controller: product_weight_controller,
                    product_price_controller: product_price_controller);
              });
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: Colors.white,),
            const SizedBox(width: 10,),
            const Text('Добавить продукцию', style: TextStyle(fontSize: 12, color: Colors.white),),
          ],
        ),
      ),
    );
  }
}
