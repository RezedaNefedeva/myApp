
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:production_app/exports.dart';
import 'package:production_app/hive_service.dart';
import 'package:production_app/widgets/dark_btn.dart';

class AlerdDialogAddIngredient extends StatefulWidget {
  const AlerdDialogAddIngredient({super.key,
    required this.product_title_controller,
    required this.product_weight_controller,
    required this.product_price_controller
  });
  final TextEditingController product_title_controller;
  final TextEditingController product_price_controller;
  final TextEditingController product_weight_controller;

  @override
  State<AlerdDialogAddIngredient> createState() => _AlerdDialogAddIngredientState();
}

class _AlerdDialogAddIngredientState extends State<AlerdDialogAddIngredient> {

  @override
  Widget build(BuildContext context) {

    final text_theme = Theme.of(context);

    // int price = widget.product_price_controller.text.isEmpty?0:int.parse(widget.product_price_controller.text);

    return AlertDialog(
      title: Text('Добавить ингредиент', style: text_theme.textTheme.bodyLarge,),
      content: Container(
        height: 200,
        child: Column(
          children: [
            TextField(
              controller: widget.product_title_controller,
              decoration: const InputDecoration(
                hintText: 'Название ингредиента'
              ),
            ),
            TextField(
              controller: widget.product_weight_controller,
              decoration: const InputDecoration(
                  hintText: 'За какой вес цена'
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: widget.product_price_controller,
              decoration: const InputDecoration(
                  hintText: 'Цена'
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                setState((){
                  HiveServiceIngredient.addIngredient(IngredientModel(
                      widget.product_title_controller.text,
                      widget.product_weight_controller.text,
                      widget.product_price_controller.text.isEmpty?0:int.parse(widget.product_price_controller.text)));
                  // FirebaseFirestore.instance.collection('ingredients').doc(widget.product_title_controller.text).set({
                  //   'name' : widget.product_title_controller.text,
                  //   'weight' : widget.product_weight_controller.text,
                  //   'price' : widget.product_price_controller.text
                  // });
                });

                Navigator.pop(context);
              },
              child: const DarkBtn(text: 'Добавить', btn_width: 240, btn_height: 60,),
            )
          ],
        )
      ],
    );
  }
}
