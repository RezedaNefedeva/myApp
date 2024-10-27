
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:production_app/exports.dart';
import 'package:production_app/hive_service.dart';
import 'package:production_app/widgets/dark_btn.dart';

class MadePage extends StatefulWidget {
  const MadePage({super.key});

  @override
  State<MadePage> createState() => _MadePageState();
}

class _MadePageState extends State<MadePage> {

  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    getNameList();
    getProductNameList();
    initFirebase();
    super.initState();
  }

  TextEditingController _dateController = TextEditingController();

  TextEditingController amoun_controller = TextEditingController();

  TextEditingController work_controller = TextEditingController();

  List<String> composition_name_list = [];

  List<String> product_name_list = [];

  String name = '';

  int composition_total = 0;

  int product_total = 0;

  int work = 0;
  
  double product_amount = 0;

  double product_weight = 0;

  double made_product_weight = 0;

  double total_weight = 0;

  List<UsedCompositioinModel> composition_ingredient_list = [];

  String used_compositions_list = '';

  String made_products_list_string = '';

  String getUsedCompositionsList(){
    for(int i = 0; i<composition_ingredient_list.length; i++){
      used_compositions_list = used_compositions_list + '\n${i + 1}. ${composition_ingredient_list[i].composition_name}, ${composition_ingredient_list[i].weight}, ${composition_ingredient_list[i].total};';
    }
    return used_compositions_list;
  }

  List<MadeProductModel> made_product_list = [];

  String getMadeProductList(){
    for(int i = 0; i<made_product_list.length; i++){
      made_products_list_string = made_products_list_string + '\n${i + 1}. ${made_product_list[i].product_name}, ${made_product_list[i].amount}, ${made_product_list[i].total};';
    }
    return made_products_list_string;
  }

  void getUsedCompoditionCollection(){
    for(int i = 0; i<composition_ingredient_list.length; i++){
      FirebaseFirestore.instance.collection('made_products')
          .doc(_dateController.text)
          .collection('used_compositions')
          .doc(composition_ingredient_list[i].composition_name)
          .set({
        'weight' : composition_ingredient_list[i].weight,
        'total' : composition_ingredient_list[i].total,
      });
    }
  }

  void getMadeProductCollection(){
    for(int i = 0; i<made_product_list.length; i++){
      FirebaseFirestore.instance.collection('made_products')
          .doc(_dateController.text)
          .collection('made_products')
          .doc(made_product_list[i].product_name)
          .set({
        'amount' : made_product_list[i].amount,
        'total' : made_product_list[i].total,
      });
    }
  }

  List<String> getNameList() {
    List<CompositionModel> compositions = HiveServiceComposition.getAllCompositions();

    for(int i = 0; i<compositions.length; i++){
      composition_name_list.add(compositions[i].title);
    }
    return composition_name_list;
  }

  List<String> getProductNameList(){
    List<ProductModel> products = HiveServiceProduct.getAllProducts();

    for(int i = 0; i<products.length; i++){
      product_name_list.add(products[i].product_name);
    }

    return product_name_list;
  }

  int getPrice(String compositionName){
    List<CompositionModel> compositions = HiveServiceComposition.getAllCompositions();
    for(int i = 0; i<compositions.length; i++){
      if(compositions[i].title == compositionName){
        composition_total = compositions[i].total;
      }
    }
    return composition_total;
  }

  int getProductPrice(String productName){
    List<ProductModel> products = HiveServiceProduct.getAllProducts();
    for(int i = 0; i<products.length; i++){
      if(products[i].product_name == productName){
        product_total = products[i].product_price;
      }
    }
    return product_total;
  }

  double getProductWeight(String productName){
    List<ProductModel> products = HiveServiceProduct.getAllProducts();
    for(int i = 0; i<products.length; i++){
      if(products[i].product_name == productName){
        product_weight = products[i].weight;
      }
    }
    return product_weight;
  }
  
  double getMadeProductWeight(String productName){
    made_product_weight = getProductWeight(productName)*product_amount;
    return made_product_weight;
  }

  void itemSelectedChanged(String? s){
    name = s!;
  }

  int getTotal(){
    int total = 0;
    for(int i = 0; i<composition_ingredient_list.length; i++){
      total = composition_ingredient_list[i].total + total;
    }
    return total;
  }

  int getProductTotal(){
    int total = 0;
    for(int i = 0; i<made_product_list.length; i++){
      total = made_product_list[i].total + total;
    }
    return total;
  }

  int getFinalTotal(){
    return getProductTotal() - getTotal() - work;
  }

  String btn_text = 'Добавить';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Произведено', style: textTheme.textTheme.bodyLarge,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              TextField(
                textAlign: TextAlign.center,
                controller: _dateController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Дата',
                  hintStyle: textTheme.textTheme.bodyLarge,
                  alignLabelWithHint: true,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff70426A), width: 3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff70426A), width: 3),
                    borderRadius: BorderRadius.circular(20),
                  )
                ),
                readOnly: true,
                onTap: (){
                  _selectDate();
                },
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  showDialog(context: context,
                      builder: (context){
                        return AlertDialog(
                            title: Text('Добавить состав', style: textTheme.textTheme.bodyLarge,),
                            content: Container(
                              width: double.maxFinite,
                              height: 100,
                              child: Column(
                                children: [
                                  DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    items: composition_name_list,
                                    dropdownSearchDecoration: const InputDecoration(
                                      hintText: 'Выбрать состав',
                                    ),
                                    onChanged: itemSelectedChanged,
                                    scrollbarProps: const ScrollbarProps(),
                                  ),
                                  TextField(
                                    controller: amoun_controller,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      hintText: 'Количество',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [InkWell(
                                      onTap: (){
                                        if(amoun_controller.text == ''){
                                          setState(() {
                                            btn_text = 'Добавьте количество';
                                          });
                                        } else {
                                          UsedCompositioinModel used_composition = UsedCompositioinModel(
                                              composition_ingredient_list.length+1,
                                              name,
                                              double.parse(amoun_controller.text),
                                              getPrice(name)*int.parse(amoun_controller.text));
                                          setState(() {
                                            composition_ingredient_list.add(used_composition);
                                            amoun_controller.text = '';
                                            composition_ingredient_list;
                                          });
                                        }
                                      },
                                      child: DarkBtn(text: btn_text, btn_width: 240, btn_height: 60,),
                                    ),]
                                  ),
                                  const SizedBox(height: 20,),
                                  InkWell(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: const DarkBtn(text: 'Готово', btn_width: 240, btn_height: 60,),
                                  )
                                ],
                              )
                            ],
                          );
                      });
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xff70426A), width: 3)
                  ),
                  child: Center(
                    child: Text('Используемые ингредиенты', style: textTheme.textTheme.bodyLarge,),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: composition_ingredient_list.length,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text('Удалить состав?'),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.pop(context);
                                      },
                                      child: const DarkBtn(text: 'Отмена', btn_width: 100, btn_height: 48),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          composition_ingredient_list.removeAt(index);
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const DarkBtn(text: 'Удалить', btn_width: 100, btn_height: 48),
                                    ),
                                  ],
                                )
                              ],
                            );
                          });
                    },
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${composition_ingredient_list[index].index}'),
                            Text('${composition_ingredient_list[index].composition_name}'),
                            Text('${composition_ingredient_list[index].weight}'),
                            Text('${composition_ingredient_list[index].total}')
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  showDialog(context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text('Добавить продукт', style: textTheme.textTheme.bodyLarge,),
                          content: Container(
                            width: double.maxFinite,
                            height: 100,
                            child: Column(
                              children: [
                                DropdownSearch<String>(
                                  mode: Mode.MENU,
                                  items: product_name_list,
                                  dropdownSearchDecoration: const InputDecoration(
                                    hintText: 'Выбрать продукт',
                                  ),
                                  onChanged: itemSelectedChanged,
                                  scrollbarProps: const ScrollbarProps(),
                                ),
                                TextField(
                                  controller: amoun_controller,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    hintText: 'Количество',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        if(amoun_controller.text == ''){
                                          setState(() {
                                            btn_text = 'Добавьте количество';
                                          });
                                        } else {
                                          MadeProductModel made_product = MadeProductModel(
                                              made_product_list.length+1,
                                              name,
                                              double.parse(amoun_controller.text),
                                              getProductPrice(name)*int.parse(amoun_controller.text));
                                              product_amount = double.parse(amoun_controller.text);
                                          setState(() {
                                            made_product_list.add(made_product);
                                            amoun_controller.text = '';
                                            getMadeProductWeight(name);
                                            total_weight = made_product_weight + total_weight;
                                            made_product_list;
                                          });
                                        }
                                      },
                                      child: DarkBtn(text: btn_text, btn_width: 240, btn_height: 60,),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                InkWell(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: const DarkBtn(text: 'Готово', btn_width: 240, btn_height: 60,),
                                )
                              ],
                            )
                          ],
                        );
                      });
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xff70426A), width: 3)
                  ),
                  child: Center(
                    child: Text('Произведено продукции', style: textTheme.textTheme.bodyLarge,),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: made_product_list.length,
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text('Удалить продукт?'),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        Navigator.pop(context);
                                      },
                                      child: const DarkBtn(text: 'Отмена', btn_width: 100, btn_height: 48),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          made_product_list.removeAt(index);
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const DarkBtn(text: 'Удалить', btn_width: 100, btn_height: 48),
                                    ),
                                  ],
                                )
                              ],
                            );
                          });
                    },
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${made_product_list[index].index}'),
                            Text('${made_product_list[index].product_name}'),
                            Text('${made_product_list[index].amount}'),
                            Text('${made_product_list[index].total}')
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Работа: ', style: textTheme.textTheme.bodyLarge,),
                  InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              content: TextField(
                                keyboardType: TextInputType.number,
                                controller: work_controller,
                                decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Color(0xff70426A), width: 3),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Color(0xff70426A), width: 3),
                                      borderRadius: BorderRadius.circular(20),
                                    )
                                ),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          work = int.parse(work_controller.text);
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: DarkBtn(text: 'Готово', btn_width: 120, btn_height: 48),
                                    )
                                  ],
                                )
                              ],
                            );
                          });
                    },
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        width: 120,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Color(0xff70426A), width: 3)
                        ),
                      child: Text('$work', style: textTheme.textTheme.bodyLarge,)
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Расход: ', style: textTheme.textTheme.bodyLarge,),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xff70426A), width: 3)
                    ),
                    child: Text('${getTotal()}', style: textTheme.textTheme.bodyLarge,),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Общее: ', style: textTheme.textTheme.bodyLarge,),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Color(0xff70426A), width: 3)
                    ),
                    child: Text('${getProductTotal()}', style: textTheme.textTheme.bodyLarge,),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Доход: ', style: textTheme.textTheme.bodyLarge,),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Color(0xff70426A), width: 3)
                    ),
                    child: Text('${getFinalTotal()}', style: textTheme.textTheme.bodyLarge,),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Кг: ', style: textTheme.textTheme.bodyLarge,),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Color(0xff70426A), width: 3)
                    ),
                    child: Text('$total_weight', style: textTheme.textTheme.bodyLarge,),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  getUsedCompositionsList();
                  getMadeProductList();
                  FirebaseFirestore.instance.collection('made_products').doc(_dateController.text).set({
                    'date' : _dateController.text,
                    'used_compositions' : used_compositions_list,
                    'made_products' : made_products_list_string,
                    'work' : work,
                    'spend' : getTotal(),
                    'total' : getProductTotal(),
                    'final_total' : getFinalTotal(),
                    'kg' : total_weight,
                  });
                  getUsedCompoditionCollection();
                  getMadeProductCollection();
                  setState(() {
                    _dateController.text = '';
                    composition_ingredient_list.clear();
                    made_product_list.clear();
                    work = 0;
                    composition_total = 0;
                    product_total = 0;
                    total_weight = 0;
                    used_compositions_list = '';
                    made_products_list_string = '';
                  });
                },
                  child: const DarkBtn(text: 'Готово', btn_width: 300, btn_height: 60)),
              const SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }

  Future <void> _selectDate() async{
    DateTime? _picked = await showDatePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if(_picked!=null){
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
