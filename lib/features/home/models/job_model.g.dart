// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JobModelAdapter extends TypeAdapter<JobModel> {
  @override
  final int typeId = 0;

  @override
  JobModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return JobModel(
      id: fields[0] as int,
      title: fields[1] as String,
      company: fields[2] as String,
      location: fields[3] as String,
      salary: fields[4] as String,
      description: fields[5] as String,
      type: fields[6] as String,
      experience: fields[7] as String,
      skills: (fields[8] as List).cast<String>(),
      postedDate: fields[9] as DateTime,
      isRemote: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, JobModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.company)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.salary)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.experience)
      ..writeByte(8)
      ..write(obj.skills)
      ..writeByte(9)
      ..write(obj.postedDate)
      ..writeByte(10)
      ..write(obj.isRemote);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
