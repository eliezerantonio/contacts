import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class UserManager extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  UserProvider() {
    loadCurrentUser();
  }

  UserModel user = UserModel();
  bool _loading = false;

//login

  Future<bool> login(
    String? email,
    String? password,
  ) async {
    loading = true;

    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: email!, password: password!);

      await loadCurrentUser(firebaseUser: result);

      return true;
    } on PlatformException catch (e) {
      return false;
    } finally {
      loading = false;
    }
  }

//cadastro
  Future<bool> signUp(
    String? email,
    String? password,
    String? name,
  ) async {
    loading = true;
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email!, password: password!);

      user.id = result.user!.uid;
      user.email = email;
      user.name = "name";
      user.saveData();
      //chamando o metodo salvar

      return true;
    } on PlatformException catch (e) {
      return false;
    } finally {
      loading = false;
    }
  }

  Future<void> loadCurrentUser({UserCredential? firebaseUser}) async {
    final currentUser = firebaseUser?.user! ?? auth.currentUser;

    // currentUser.sendEmailVerification();
    if (currentUser != null) {
      final DocumentSnapshot docUser =
          await firestore.collection('users').doc(currentUser.uid).get();
      user = UserModel.fromDocument(docUser);

      try {
        //verificando usuario admin
        final docAdmin =
            await firestore.collection('admins').doc(user.id).get();

        notifyListeners();
      } catch (e) {}
      notifyListeners();
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
