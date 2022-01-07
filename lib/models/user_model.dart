import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    this.email,
    this.name,
    this.password,
  });
  String? id;
  String? email;
  String? name;
  String? password;

  UserModel.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    id = document.id;
    name = data['name'] as String;
    email = data['email'] as String;
  }

  DocumentReference get firestoreRef =>
      FirebaseFirestore.instance.collection('users').doc(id);

  Future<void> saveData() async {
    await firestoreRef.set(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
