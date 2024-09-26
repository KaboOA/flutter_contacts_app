// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_contacts_app/constants/widgets.dart';

import '../data/contact_db.dart';
import '../model/contact_model.dart';

class AddEditScreen extends StatefulWidget {
  AddEditScreen({
    super.key,
    this.cm,
    this.index,
  });
  ContactModel? cm;
  int? index;

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  var conactDatabase = ContactDataBase();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumController = TextEditingController();

  var fKey = GlobalKey<FormState>();

  void addContact({
    required String name,
    required String email,
    required String phone,
  }) {
    ContactModel contactModel = ContactModel(
      name: name,
      email: email,
      phoneNum: phone,
    );
    conactDatabase.addContact(contactModel);

    Navigator.pop(context, contactModel);
  }

  void updateContact({
    required String name,
    required String email,
    required String phone,
  }) {
    ContactModel contactModel = ContactModel(
      name: name,
      email: email,
      phoneNum: phone,
    );
    conactDatabase.updateContact(widget.index!, contactModel);

    Navigator.pop(context, contactModel);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.cm != null) {
      nameController.text = widget.cm!.name;
      phoneNumController.text = widget.cm!.phoneNum;
      emailController.text = widget.cm!.email;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          '${widget.cm == null ? 'Add' : 'Edit'} Contact',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: fKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              DefaultTextFormField(
                txt: 'Name',
                preIcon: Icons.person,
                controller: nameController,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 12.0),
              DefaultTextFormField(
                preIcon: Icons.phone,
                txt: 'Phone Number',
                controller: phoneNumController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12.0),
              DefaultTextFormField(
                preIcon: Icons.email,
                txt: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (fKey.currentState!.validate()) {
                    if (widget.cm == null) {
                      addContact(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneNumController.text,
                      );
                    } else {
                      updateContact(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneNumController.text,
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  minimumSize: const Size(180, 50),
                ),
                child: const Text(
                  'Save Contact',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
