// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardDtoAdapter extends TypeAdapter<CardDto> {
  @override
  final int typeId = 0;

  @override
  CardDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardDto(
      cardName: fields[0] as String,
      balance: (fields[2] as num).toInt(),
      holderName: fields[1] as String,
      color: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CardDto obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.cardName)
      ..writeByte(1)
      ..write(obj.holderName)
      ..writeByte(2)
      ..write(obj.balance)
      ..writeByte(3)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
