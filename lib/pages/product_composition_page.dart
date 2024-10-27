
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:production_app/exports.dart';
import 'package:production_app/hive_service.dart';
import 'package:production_app/widgets/compositions/composition_details.dart';
import 'package:production_app/widgets/widgets.dart';

class ProductCompositionPage extends StatefulWidget {
  const ProductCompositionPage({super.key});

  @override
  State<ProductCompositionPage> createState() => _ProductCompositionPageState();
}

class _ProductCompositionPageState extends State<ProductCompositionPage> {

  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  List<CompositionModel> compositions = <CompositionModel>[];

  @override
  void initState() {
    initFirebase();
    super.initState();
    compositions = HiveServiceComposition.getAllCompositions();
  }

  @override
  Widget build(BuildContext context) {
    final text_theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Составы', style: text_theme.textTheme.bodyLarge,),
        centerTitle: true,
      ),
      floatingActionButton: AddCompositions(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: ListView.builder(
            itemCount: compositions.length,
            itemBuilder: (BuildContext context, int index){
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xff70426A), width: 3),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: ListTile(
                  title: Text(compositions[index].title, textAlign: TextAlign.center,),
                  onTap: (){
                      showModalBottomSheet(
                          context: context,
                          builder: (context){
                            return CompositionDetails(
                                title: compositions[index].title,
                                ingredient_list: compositions[index].list,
                                total: compositions[index].total);
                          });
                  },
                ),
              );
            }),
      )
    );
  }
}
