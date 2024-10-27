
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:production_app/hive_service.dart';
import 'package:production_app/models/ingredients/ingredient_model.dart';
import 'package:production_app/widgets/dark_btn.dart';
import 'package:production_app/widgets/ingredients/ingredient_card.dart';
import 'package:production_app/widgets/widgets.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({super.key});

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {

  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState(){
    ingredientList = HiveServiceIngredient.getAllIngredients();
    initFirebase();
    super.initState();
  }

  List<IngredientModel> ingredientList = <IngredientModel>[];


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Ингредиенты', style: textTheme.textTheme.bodyLarge,),
          centerTitle: true,
        ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
                itemCount: ingredientList.length,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    onTap: (){
                      showDialog(context: context,
                          builder: (context){
                        return AlertDialog(
                          title: Text('Удалить позицию ${ingredientList[index].name}', style: textTheme.textTheme.bodyMedium,),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: const DarkBtn(text: 'Отмена', btn_width: 110, btn_height: 48),
                                ),
                                InkWell(
                                  onTap: (){
                                    HiveServiceIngredient.deleteIngredient(index);
                                    setState(() {

                                    });
                                    FirebaseFirestore.instance.collection('ingredients').doc(ingredientList[index].name).delete();
                                    Navigator.pop(context);
                                  },
                                  child: const DarkBtn(text: 'Удалить', btn_width: 110, btn_height: 48),
                                )
                              ],
                            )
                          ],
                        );
                          });
                    },
                    child:
                    IngredientCard(
                        index: index,
                        name: ingredientList[index].name,
                        weight: ingredientList[index].weight,
                        price: ingredientList[index].price),
                  );
                  })
      ),
      floatingActionButton: const AddIngredients()
    );
  }
}
