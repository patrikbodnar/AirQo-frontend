// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enum_constants.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppNotificationTypeAdapter extends TypeAdapter<AppNotificationType> {
  @override
  final int typeId = 110;

  @override
  AppNotificationType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return AppNotificationType.appUpdate;
      case 1:
        return AppNotificationType.reminder;
      case 2:
        return AppNotificationType.welcomeMessage;
      default:
        return AppNotificationType.appUpdate;
    }
  }

  @override
  void write(BinaryWriter writer, AppNotificationType obj) {
    switch (obj) {
      case AppNotificationType.appUpdate:
        writer.writeByte(0);
        break;
      case AppNotificationType.reminder:
        writer.writeByte(1);
        break;
      case AppNotificationType.welcomeMessage:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppNotificationTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RegionAdapter extends TypeAdapter<Region> {
  @override
  final int typeId = 140;

  @override
  Region read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 1:
        return Region.central;
      case 2:
        return Region.eastern;
      case 3:
        return Region.northern;
      case 4:
        return Region.western;
      case 5:
        return Region.southern;
      case 0:
        return Region.none;
      default:
        return Region.central;
    }
  }

  @override
  void write(BinaryWriter writer, Region obj) {
    switch (obj) {
      case Region.central:
        writer.writeByte(1);
        break;
      case Region.eastern:
        writer.writeByte(2);
        break;
      case Region.northern:
        writer.writeByte(3);
        break;
      case Region.western:
        writer.writeByte(4);
        break;
      case Region.southern:
        writer.writeByte(5);
        break;
      case Region.none:
        writer.writeByte(0);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
