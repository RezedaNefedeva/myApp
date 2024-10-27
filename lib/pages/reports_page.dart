
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:production_app/animation/animation.dart';
import 'package:production_app/exports.dart';
import 'package:production_app/pages/day_reports.dart';
import 'package:production_app/widgets/widgets.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
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
                  Navigator.push(context, EnterExitRoute(exitPage: const MainPage(), enterPage: const DayReports()));
                },
                child: const WhiteBtn(text: 'По дате'),
              ),
              const SizedBox(height: 40,),
              InkWell(
                onTap: (){
                  // Navigator.push(context, EnterExitRoute(exitPage: const MainPage(), enterPage: const ProductionPage()));
                },
                child: const WhiteBtn(text: 'По продукции'),
              ),
              const SizedBox(height: 40,),
            ],
          )
      ),
    );
  }
}
