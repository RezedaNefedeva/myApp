// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'full_info_production_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FullInfoProductionModelAdapter
    extends TypeAdapter<FullInfoProductionModel> {
  @override
  final int typeId = 6;

  @override
  FullInfoProductionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FullInfoProductionModel(
      fields[0] as DateTime,
      (fields[1] as List).cast<UsedCompositioinModel>(),
      (fields[2] as List).cast<MadeProductModel>(),
      fields[3] as int,
      fields[4] as int,
      fields[5] as int,
      fields[6] as int,
      fields[7] as double,
    );
  }

  @override
  void write(BinaryWriter writer, FullInfoProductionModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.dateTime)
      ..writeByte(1)
      ..write(obj.composition_list)
      ..writeByte(2)
      ..write(obj.products_list)
      ..writeByte(3)
      ..write(obj.work_price)
      ..writeByte(4)
      ..write(obj.spend)
      ..writeByte(5)
      ..write(obj.total)
      ..writeByte(6)
      ..write(obj.finance)
      ..writeByte(7)
      ..write(obj.kg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FullInfoProductionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
