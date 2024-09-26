// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_contacts_app/data/contact_db.dart';
import 'package:flutter_contacts_app/screens/add_edit_screen.dart';

import '../model/contact_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var conactDatabase = ContactDataBase();

  List<ContactModel> conatctList = [];

  @override
  void initState() {
    super.initState();
    conatctList = conactDatabase.getContacts();
  }

  void deleteAllContacts() {
    conactDatabase.deleteAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Contacts',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              deleteAllContacts();
              setState(() {
                conatctList.clear();
              });
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: conatctList.isEmpty
          ? const Center(
              child: Text(
                'No Contacts Yet!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () async {
                  ContactModel? conatct = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddEditScreen(
                        index: index,
                        cm: conatctList[index],
                      ),
                    ),
                  );
                  if (conatct != null) {
                    setState(() {
                      conatctList[index] = conatct;
                    });
                  }
                },
                child: ContactItem(
                  cm: conatctList[index],
                ),
              ),
              itemCount: conatctList.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ContactModel? conatct = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddEditScreen(),
            ),
          );
          if (conatct != null) {
            setState(() {
              conatctList.add(conatct);
            });
          }
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.pink,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  ContactItem({
    super.key,
    required this.cm,
  });
  ContactModel cm;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 5.0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22.0,
              backgroundColor: Colors.blue,
              child: Text(
                cm.name[0],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cm.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  cm.phoneNum,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
    /*
        Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      elevation: 5.0,
      child: ListTile(
        leading: CircleAvatar(
          radius: 22.0,
          backgroundColor: Colors.blue,
          child: Text(
            cm.name[0],
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          cm.name,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          cm.phoneNum,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
    */
  }
}
