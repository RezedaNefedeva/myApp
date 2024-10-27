// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'made_product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MadeProductModelAdapter extends TypeAdapter<MadeProductModel> {
  @override
  final int typeId = 5;

  @override
  MadeProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MadeProductModel(
      fields[0] as int,
      fields[1] as String,
      fields[2] as double,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MadeProductModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.product_name)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MadeProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
