
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:production_app/exports.dart';
import 'package:production_app/hive_service.dart';
import 'package:production_app/widgets/dark_btn.dart';

class AlerdDialogAddProduct extends StatefulWidget {
  const AlerdDialogAddProduct({super.key,
    required this.index,
    required this.product_title_controller,
    required this.product_weight_controller,
    required this.product_price_controller
  });
  final int index;
  final TextEditingController product_title_controller;
  final TextEditingController product_price_controller;
  final TextEditingController product_weight_controller;

  @override
  State<AlerdDialogAddProduct> createState() => _AlerdDialogAddProductState();
}

class _AlerdDialogAddProductState extends State<AlerdDialogAddProduct> {

  @override
  Widget build(BuildContext context) {

    final text_theme = Theme.of(context);

    // int price = widget.product_price_controller.text.isEmpty?0:int.parse(widget.product_price_controller.text);

    return AlertDialog(
      title: Text('Добавить продукцию', style: text_theme.textTheme.bodyLarge,),
      content: Container(
        height: 200,
        child: Column(
          children: [
            TextField(
              controller: widget.product_title_controller,
              decoration: const InputDecoration(
                  hintText: 'Название'
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: widget.product_weight_controller,
              decoration: const InputDecoration(
                  hintText: 'Вес'
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
                  HiveServiceProduct.addProduct(ProductModel(
                      widget.index,
                      widget.product_title_controller.text,
                      double.parse(widget.product_weight_controller.text),
                      widget.product_price_controller.text.isEmpty?0:int.parse(widget.product_price_controller.text)));
                });
                FirebaseFirestore.instance.collection('products').doc(widget.product_title_controller.text).set({
                  'index': widget.index,
                  'name' : widget.product_title_controller.text,
                  'weight' : widget.product_weight_controller.text,
                  'price' : widget.product_price_controller.text
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
