import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts/models/contacts.dart';
import 'package:flutter/cupertino.dart';

class ContactManager extends ChangeNotifier {
  ContactManager() {
    getContacts();
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  bool _loading = false;
  List<Contact> contacts = [];

  Future<void> getContacts() async {
    final QuerySnapshot snapshot = await firestore.collection("contacts").get();

    contacts = snapshot.docs.map((e) => Contact.fromDocument(e)).toList();
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get loading => _loading;
}
