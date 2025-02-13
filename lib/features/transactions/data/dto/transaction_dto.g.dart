// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionDtoAdapter extends TypeAdapter<TransactionDto> {
  @override
  final int typeId = 1;

  @override
  TransactionDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionDto(
      id: fields[0] as String,
      name: fields[1] as String,
      image: fields[2] as String,
      merchant: fields[3] as String,
      billingAmount: (fields[4] as num).toInt(),
      date: (fields[5] as num).toInt(),
      billingCurrency: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TransactionDto obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.merchant)
      ..writeByte(4)
      ..write(obj.billingAmount)
      ..writeByte(5)
      ..write(obj.date)
      ..writeByte(6)
      ..write(obj.billingCurrency);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
