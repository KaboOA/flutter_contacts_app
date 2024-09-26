import 'package:flutter_contacts_app/model/contact_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ContactDataBase {
  final _myBox = Hive.box<ContactModel>('contactBox');

  void addContact(ContactModel contactModel) {
    _myBox.add(contactModel);
  }

  List<ContactModel> getContacts() {
    return _myBox.isNotEmpty ? _myBox.values.toList() : [];
  }

  void deleteAllContacts() {
    _myBox.clear();
  }

  void updateContact(int index, ContactModel contactModel) {
    _myBox.putAt(index, contactModel);
  }
}
