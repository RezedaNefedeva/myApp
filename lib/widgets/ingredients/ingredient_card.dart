
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:production_app/exports.dart';
import 'package:production_app/hive_service.dart';
import 'package:production_app/widgets/dark_btn.dart';

class IngredientCard extends StatefulWidget {
  IngredientCard({super.key,
    required this.index,
  required this.name,
    required this.weight,
    required this.price
  });
  final int index;
  final String name;
  final String weight;
  int price;

  @override
  State<IngredientCard> createState() => _IngredientCardState();
}

class _IngredientCardState extends State<IngredientCard> {
  TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff70426A), width: 3),
        borderRadius: BorderRadius.circular(20)
      ),
      width: MediaQuery.of(context).size.width-20,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.name),
          Text(widget.weight),
          InkWell(
            onTap: (){
              showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: const Text('Новая цена'),
                      content: TextField(
                        controller: priceController,
                      ),
                      actions: [
                        InkWell(
                          onTap: (){
                            HiveServiceIngredient.updateIngredient(
                                widget.index,
                                IngredientModel(widget.name, widget.weight, int.parse(priceController.text)));
                            setState(() {widget.price = int.parse(priceController.text);});
                            // FirebaseFirestore.instance.collection('ingredients').doc(widget.name).update({
                            //   'price' : priceController.text
                            // });
                            Navigator.pop(context);
                          },
                          child: const DarkBtn(
                              text: 'Обновить',
                              btn_width: 220,
                              btn_height: 48),
                        )
                      ],
                    );
                  });
            },
              child: Text('${widget.price} руб'))
        ],
      ),
    );
  }
}
