
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:production_app/animation/animation.dart';
import 'package:production_app/exports.dart';
import 'package:production_app/pages/components_page.dart';
import 'package:production_app/widgets/white_btn.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
                  Navigator.push(context, EnterExitRoute(exitPage: const MainPage(), enterPage: const ComponentsPage()));
                },
                child: const WhiteBtn(text: 'Составляющие'),
              ),
              const SizedBox(height: 40,),
              InkWell(
                onTap: (){
                  Navigator.push(context, EnterExitRoute(exitPage: const MainPage(), enterPage: const MadePage()));
                },
                child: const WhiteBtn(text: 'Производство'),
              ),
              const SizedBox(height: 40,),
              InkWell(
                onTap: (){
                  Navigator.push(context, EnterExitRoute(exitPage: const MainPage(), enterPage: const ReportsPage()));
                },
                child: const WhiteBtn(text: 'Отчеты'),
              ),
            ],
          )
      ),
    );
  }
}
