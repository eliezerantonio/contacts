import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Contact extends ChangeNotifier {
  Contact({
    this.id,
    this.phone,
    this.name,
    this.email,
  });

  String? id;
  String? phone;
  String? name;
  String? email;

  Contact.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    id = document.id;
    name = data['name'] as String;
    email = data['email'] as String;
    phone = data['phone'] as String;
  }

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.collection('contacts').doc(id);

  Future<bool> save(String name, String email, String phone) async {
    loading = true;
    try {
      this.name = name;
      this.email = email;
      this.phone = phone;

      await firestoreRef.set(toMap());
      return true;
    } catch (e) {
      return false;
    } finally {
      loading = false;
    }
  }

  Future<bool> update(
      String name, String email, String phone, String id) async {
    print("$id,$name, $email");
    loading = true;
    try {
      this.name = name;
      this.email = email;
      this.phone = phone;
      this.id = id;

      print(id);
      FirebaseFirestore.instance.collection('contacts').doc(id).update(toMap());
      return true;
    } catch (e) {
      return false;
    } finally {
      loading = false;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  bool _loading = false;
  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
