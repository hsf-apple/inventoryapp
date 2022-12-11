import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Model/UserModel/userModel.dart';

class UserRepository {
  CollectionReference db = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(UserModel userModel, String email) async{
    await db.doc(email).set({
      'name': userModel.name,
      'email': userModel.email,
      'userID': userModel.userID,
      'telNumber': userModel.telNumber,
    });
    return;
  }

  Future<void> updateUser(UserModel userModel, String email) async{
    await db.doc(email).update({
      'name': userModel.name,
      'email': userModel.email,
      'telNumber': userModel.telNumber,
      'userID': userModel.userID,
    });
    return;
  }

  Future<DocumentSnapshot<Object?>> getSpecificUser(String email) async {
    return await db.doc(email).get();
  }
}
