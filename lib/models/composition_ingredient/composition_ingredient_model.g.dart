// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'composition_ingredient_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CompositionIngredientModelAdapter
    extends TypeAdapter<CompositionIngredientModel> {
  @override
  final int typeId = 2;

  @override
  CompositionIngredientModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompositionIngredientModel(
      fields[0] as int,
      fields[1] as String,
      fields[2] as double,
      fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CompositionIngredientModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.total_price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompositionIngredientModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
