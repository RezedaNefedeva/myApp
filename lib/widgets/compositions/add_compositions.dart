
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:production_app/widgets/ingredients/alerd_dialog_add_ingredient.dart';
import 'package:production_app/widgets/compositions/alert_dialog_add_compositions.dart';

class AddCompositions extends StatefulWidget {
  const AddCompositions({super.key});

  @override
  State<AddCompositions> createState() => _AddCompositionsState();
}

class _AddCompositionsState extends State<AddCompositions> {

  final TextEditingController composition_title_controller = TextEditingController();
  final TextEditingController first_ingredient_controller = TextEditingController();
  final TextEditingController first_ingredient_amount_controller = TextEditingController();
  final TextEditingController second_ingredient_controller = TextEditingController();
  final TextEditingController third_ingredient_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                return AlerdDialogAddCompositions(
                    composition_title_controller: composition_title_controller,
                    first_ingredient_controller: first_ingredient_controller,
                    first_ingredient_amount_controller: first_ingredient_amount_controller,);
              });
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: Colors.white,),
            const SizedBox(width: 10,),
            const Text('Добавить состав', style: TextStyle(fontSize: 12, color: Colors.white),),
          ],
        ),
      ),
    );
  }
}