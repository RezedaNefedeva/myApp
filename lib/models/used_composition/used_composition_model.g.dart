// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'used_composition_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UsedCompositioinModelAdapter extends TypeAdapter<UsedCompositioinModel> {
  @override
  final int typeId = 4;

  @override
  UsedCompositioinModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UsedCompositioinModel(
      fields[0] as int,
      fields[1] as String,
      fields[2] as double,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UsedCompositioinModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.composition_name)
      ..writeByte(2)
      ..write(obj.weight)
      ..writeByte(3)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsedCompositioinModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
