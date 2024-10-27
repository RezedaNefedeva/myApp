
import 'package:flutter/material.dart';

class PeriodReportsInfoCard extends StatefulWidget {
  const PeriodReportsInfoCard({super.key,
    required this.date,
    required this.used_compositions,
    required this.made_products,
    required this.work,
    required this.spend,
    required this.total,
    required this.final_total,
    required this.kg
  });
  final String date;
  final String used_compositions;
  final String made_products;
  final int work;
  final int spend;
  final int total;
  final int final_total;
  final double kg;

  @override
  State<PeriodReportsInfoCard> createState() => _PeriodReportsInfoCardState();
}

class _PeriodReportsInfoCardState extends State<PeriodReportsInfoCard> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context);
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xff70426A), width: 3)
    ),
        child: Column(
          children: [
            Row(
              children: [
                Text('Дата:', style: textTheme.textTheme.bodyMedium,),
                const SizedBox(width: 10,),
                Text('${widget.date}', style: textTheme.textTheme.bodyMedium,),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Text('Использовали:', style: textTheme.textTheme.bodyMedium,),
                const SizedBox(width: 10,),
                Text('${widget.used_compositions}', style: textTheme.textTheme.bodyMedium,),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Text('Сделали:', style: textTheme.textTheme.bodyMedium,),
                const SizedBox(width: 10,),
                Text('${widget.made_products}', style: textTheme.textTheme.bodyMedium,),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Text('Работа:', style: textTheme.textTheme.bodyMedium,),
                const SizedBox(width: 10,),
                Text('${widget.work}', style: textTheme.textTheme.bodyMedium,),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Text('Расход:', style: textTheme.textTheme.bodyMedium,),
                const SizedBox(width: 10,),
                Text('${widget.spend}', style: textTheme.textTheme.bodyMedium,),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Text('Общее:', style: textTheme.textTheme.bodyMedium,),
                const SizedBox(width: 10,),
                Text('${widget.total}', style: textTheme.textTheme.bodyMedium,),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Text('Доход:', style: textTheme.textTheme.bodyMedium,),
                const SizedBox(width: 10,),
                Text('${widget.final_total}', style: textTheme.textTheme.bodyMedium,),
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              children: [
                Text('Кг:', style: textTheme.textTheme.bodyMedium,),
                const SizedBox(width: 10,),
                Text('${widget.kg}', style: textTheme.textTheme.bodyMedium,),
              ],
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
