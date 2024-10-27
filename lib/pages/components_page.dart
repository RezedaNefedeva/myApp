
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:production_app/animation/animation.dart';
import 'package:production_app/exports.dart';
import 'package:production_app/widgets/widgets.dart';

class ComponentsPage extends StatefulWidget {
  const ComponentsPage({super.key});

  @override
  State<ComponentsPage> createState() => _ComponentsPageState();
}

class _ComponentsPageState extends State<ComponentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/fon.png'), fit: BoxFit.fill),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context, EnterExitRoute(exitPage: const ComponentsPage(), enterPage: const IngredientsPage()));
                },
                child: const WhiteBtn(text: 'Ингредиенты'),
              ),
              const SizedBox(height: 40,),
              InkWell(
                onTap: (){
                  Navigator.push(context, EnterExitRoute(exitPage: const ComponentsPage(), enterPage: const ProductCompositionPage()));
                },
                child: const WhiteBtn(text: 'Составы'),
              ),
              const SizedBox(height: 40,),
              InkWell(
                onTap: (){
                  Navigator.push(context, EnterExitRoute(exitPage: const ComponentsPage(), enterPage: const ProductionPage()));
                },
                child: const WhiteBtn(text: 'Продукция'),
              ),
              const SizedBox(height: 40,),
            ],
          )
      ),
    );
  }
}