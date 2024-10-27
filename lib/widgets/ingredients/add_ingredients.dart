
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:production_app/exports.dart';
import 'package:production_app/hive_service.dart';
import 'package:production_app/widgets/ingredients/alerd_dialog_add_ingredient.dart';

import '../dark_btn.dart';

class AddIngredients extends StatefulWidget {
  const AddIngredients({super.key});

  @override
  State<AddIngredients> createState() => _AddIngredientsState();
}

class _AddIngredientsState extends State<AddIngredients> {

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
                return AlerdDialogAddIngredient(
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
            const Text('Добавить ингредиент', style: TextStyle(fontSize: 12, color: Colors.white),),
          ],
        ),
          ),
    );
  }
}
