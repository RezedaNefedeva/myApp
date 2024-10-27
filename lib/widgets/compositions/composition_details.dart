
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:production_app/models/composition_ingredient/composition_ingredient_model.dart';

class CompositionDetails extends StatefulWidget {
  const CompositionDetails({super.key,
    required this.title,
    required this.ingredient_list,
    required this.total
  });
  final String title;
  final List<CompositionIngredientModel> ingredient_list;
  final int total;

  @override
  State<CompositionDetails> createState() => _CompositionDetailsState();
}

class _CompositionDetailsState extends State<CompositionDetails> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Center(
        child: Column(
          children: [
            Text(widget.title, style: textTheme.textTheme.bodyLarge,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.ingredient_list.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('${widget.ingredient_list[index].index}'),
                            const SizedBox(width: 10,),
                            Text('${widget.ingredient_list[index].name}'),
                          ],
                        ),
                        Row(
                          children: [
                            Text('${widget.ingredient_list[index].amount}'),
                            const SizedBox(width: 10,),
                            Text('${widget.ingredient_list[index].total_price}')
                          ],
                        )
        
                      ],
                    ),
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Итого'),
                const SizedBox(width: 10,),
                Text('${widget.total}'),
                const SizedBox(width: 4,),
                const Text('руб'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
