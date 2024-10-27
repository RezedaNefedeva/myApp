import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class GetInfoModel {
  final String date;
  final String used_compositions;
  final String made_product;
  final int work;
  final int spend;
  final int total;
  final int final_total;
  final double kg;

  GetInfoModel(this.date, this.used_compositions, this.made_product, this.work, this.spend, this.total, this.final_total, this.kg);

  factory GetInfoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return GetInfoModel(
        data['date'],
        data['used_compositions'],
        data['made_products'],
        data['work'],
        data['spend'],
        data['total'],
        data['final_total'],
        data['kg']);
  }
}