
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:production_app/models/get_info_model/get_info_model.dart';
import 'package:production_app/widgets/dark_btn.dart';
import 'package:production_app/widgets/report/period_reports_info_card.dart';

class DayReports extends StatefulWidget {
  const DayReports({super.key});

  @override
  State<DayReports> createState() => _DayReportsState();
}

class _DayReportsState extends State<DayReports> {

  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState(){
    initFirebase();
    super.initState();
  }

  DateTimeRange _selectedDays = DateTimeRange(start: DateTime.now(), end: DateTime.now());
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  String dates_for_report = '';
  List<String> dates_list = [];
  int choosed_days = 0;

  void getPeriodReport()async{
    dates_list.clear();
    for(int i = 0; i<choosed_days; i++){
      final date = start.add(Duration(days: i));
      dates_for_report = '${date.year}-${date.month}-${date.day}';
      dates_list.add(dates_for_report);
    }
  }

  List<GetInfoModel> report_info = [];

  int total_work = 0;
  List<int> total_work_list = [];

  int GetTotalWork(){
    for(int i = 0; i<total_work_list.length; i++){
      total_work = total_work_list[i] + total_work;
      print('!!!!!!!!!!${total_work_list[i]}');
    }
    return total_work;
  }

  int total_total = 0;
  int total_spend = 0;
  int roral_final_total = 0;
  double total_kg = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Отчет по датам', style: textTheme.textTheme.bodyLarge,),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width-20,
        height: MediaQuery.of(context).size.height - 200,
        child: Column(
          children: [
            InkWell(
            onTap: ()async{
              dates_list.clear();
              final DateTimeRange? dateTimeRange = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2400));
              if(dateTimeRange!=null){
                setState(() {
                  _selectedDays = dateTimeRange;
                  start = _selectedDays.start;
                  end = _selectedDays.end;
                  choosed_days = _selectedDays.duration.inDays+1;
                  getPeriodReport();
                });
              }
            },
            child: DarkBtn(text: 'Выбрать период', btn_width: 300, btn_height: 60),
          ),
            Text('С ${start.day}-${start.month}-${start.year} по ${end.day}-${end.month}-${end.year}'),
            Container(
              height: 400,
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('made_products').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text ('Проверьте интернет соединение', style: textTheme.textTheme.titleMedium,),
                    );}
                  report_info.clear();
                  for(int i = 0; i<snapshot.data!.docs.length; i++){
                    GetInfoModel day_info = GetInfoModel(
                      snapshot.data!.docs[i].get('date'),
                      snapshot.data!.docs[i].get('used_compositions'),
                      snapshot.data!.docs[i].get('made_products'),
                      snapshot.data!.docs[i].get('work'),
                      snapshot.data!.docs[i].get('spend'),
                      snapshot.data!.docs[i].get('total'),
                      snapshot.data!.docs[i].get('final_total'),
                      snapshot.data!.docs[i].get('kg'),
                    );
                    report_info.add(day_info);
                  }
                  print('!!!${report_info.length}');

                    return ListView.builder(
                      itemCount: dates_list.length,
                        itemBuilder: (BuildContext context, int index) {
                          // for (int i = 0; i < snapshot.data!.docs.length; i++) {

                            // for(int j = 0; j<dates_list.length; j++){
                            //   if (dates_list[j]==snapshot.data!.docs[index].get('date')) {
                            //     int _total_work = snapshot.data!.docs[index].get('work');
                            //     total_work = total_work + _total_work;
                            //     print('!!!!!!!!!!!!!!!${snapshot.data!.docs[index].get('date')}');
                            //     print('!!!!!!!!!$_total_work');
                            //     print('!!!!!!!!!$total_work');
                            // for(int i = 0; i<report_info.length; i++){
                              for(int j = 0; j < dates_list.length; j++){
                                if(dates_list[j] == report_info[index].date){
                                  return PeriodReportsInfoCard(
                                      date: report_info[index].date,
                                      used_compositions: report_info[index].used_compositions,
                                      made_products: report_info[index].made_product,
                                      work: report_info[index].work,
                                      spend: report_info[index].spend,
                                      total: report_info[index].total,
                                      final_total: report_info[index].final_total,
                                      kg: report_info[index].kg);
                                }
                              }
                            // }

                            //   }
                            // }

                          // }
                        }
                    );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Итого:', style: textTheme.textTheme.bodyLarge,),
                Text('$total_work', style: textTheme.textTheme.bodyLarge,)
              ],
            ),
            const SizedBox(height: 20,),
          ]
        ),
      ),
    );
  }

}
