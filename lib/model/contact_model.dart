import 'package:hive_flutter/hive_flutter.dart';

part 'contact_model.g.dart';

@HiveType(typeId: 1)
class ContactModel {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String email;
  @HiveField(2)
  late String phoneNum;

  ContactModel({
    required this.name,
    required this.email,
    required this.phoneNum,
  });
}
