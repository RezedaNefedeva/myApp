
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:production_app/exports.dart';
import 'package:production_app/hive_service.dart';
import 'package:production_app/models/composition_ingredient/composition_ingredient_model.dart';
import 'package:production_app/widgets/dark_btn.dart';

class AlerdDialogAddCompositions extends StatefulWidget {
  AlerdDialogAddCompositions({super.key,
    required this.composition_title_controller,
    required this.first_ingredient_controller,
    required this.first_ingredient_amount_controller,
  });
  final TextEditingController composition_title_controller;
  final TextEditingController first_ingredient_controller;
  final TextEditingController first_ingredient_amount_controller;


  @override
  State<AlerdDialogAddCompositions> createState() => _AlerdDialogAddCompositionsState();
}

class _AlerdDialogAddCompositionsState extends State<AlerdDialogAddCompositions> {
  List<String> ingredient_name_list = [];

  String name = '';

  int ingredient_total = 0;

  List<CompositionIngredientModel> composition_ingredient_list = [];

  @override
  void initState() {
    getNameList();
    super.initState();
  }

  List<String> getNameList() {
    List<IngredientModel> ingredients_composition = HiveServiceIngredient.getAllIngredients();

    for(int i = 0; i<ingredients_composition.length; i++){
      ingredient_name_list.add(ingredients_composition[i].name);
    }
    return ingredient_name_list;
  }

  int getPrice(String ingredientName){
    List<IngredientModel> ingredients_composition = HiveServiceIngredient.getAllIngredients();
    for(int i = 0; i<ingredients_composition.length; i++){
      if(ingredients_composition[i].name == ingredientName){
        ingredient_total = ingredients_composition[i].price;
      }
    }
    return ingredient_total;
  }

  void itemSelectedChanged(String? s){
      name = s!;
  }

  int getTotal(){
    int total = 0;
    for(int i = 0; i<composition_ingredient_list.length; i++){
      total = composition_ingredient_list[i].total_price + total;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {

    final text_theme = Theme.of(context);

    return Container(
      width: MediaQuery.of(context).size.width-40,
      height: MediaQuery.of(context).size.height-200,
      child: AlertDialog(
        title: Text('Добавить состав', style: text_theme.textTheme.bodyLarge,),
        content: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Column(
            children: [
              TextField(
                controller: widget.composition_title_controller,
                decoration: const InputDecoration(
                    hintText: 'Название'
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: composition_ingredient_list.length,
                  itemBuilder: (BuildContext context, int index){
                    return Card(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${composition_ingredient_list[index].index}'),
                            Text('${composition_ingredient_list[index].name}'),
                            Text('${composition_ingredient_list[index].amount}'),
                            Text('${composition_ingredient_list[index].total_price}')
                          ],
                        ),
                      ),
                    );
                },

                ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width-100,
                height: 40,
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
                child: InkWell(
                    onTap: (){
                        showDialog(context: context,
                            builder: (context){
                          return AlertDialog(
                            content: SizedBox(
                              height: 200,
                              child: Center(
                                child: Column(
                                  children: [
                                    DropdownSearch<String>(
                                      mode: Mode.MENU,
                                      items: ingredient_name_list,
                                      dropdownSearchDecoration: const InputDecoration(
                                        hintText: 'Выбрать ингредиент',
                                      ),
                                      onChanged: itemSelectedChanged,
                                      scrollbarProps: const ScrollbarProps(),
                                    ),
                                    TextField(
                                        controller: widget.first_ingredient_amount_controller,
                                        decoration: const InputDecoration(
                                            hintText: 'Количество',
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            actions: [
                              InkWell(
                                onTap: (){
                                  CompositionIngredientModel composition_ingredient = CompositionIngredientModel(
                                      composition_ingredient_list.length+1,
                                      name,
                                      double.parse(widget.first_ingredient_amount_controller.text),
                                      getPrice(name)*int.parse(widget.first_ingredient_amount_controller.text));
                                  setState(() {
                                    composition_ingredient_list.add(composition_ingredient);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width-100,
                                  height: 40,
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
                                  child: Center(child: Text('Добавить', style: text_theme.textTheme.displaySmall,)),
                                ),
                              )
                            ],
                          );
                            });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, color: Colors.white,),
                        SizedBox(width: 20,),
                        Text('Добавить ингредиент', style: text_theme.textTheme.displaySmall,),
                      ],
                    )
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
                  CompositionModel compositionModel = CompositionModel(
                      widget.composition_title_controller.text,
                      composition_ingredient_list,
                      getTotal());
                  HiveServiceComposition.addComposition(compositionModel);
                  FirebaseFirestore.instance.collection('compositions').doc(widget.composition_title_controller.text).set({
                    'name' : widget.composition_title_controller.text,
                    'list' : composition_ingredient_list,
                    'total' : getTotal(),
                  });
                  Navigator.pop(context);
                },
                child: const DarkBtn(text: 'Добавить', btn_width: 240, btn_height: 60,),
              )
            ],
          )
        ],
      ),
    );
  }
}
