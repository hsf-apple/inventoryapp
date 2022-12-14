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
      'isAdmin': false,
    });
    return;
  }

  Future<void> updateUser(UserModel userModel, String email) async{
    await db.doc(email).update({
      'name': userModel.name,
      'email': userModel.email,
      'telNumber': userModel.telNumber,
      'userID': userModel.userID,
      'isAdmin': userModel.isAdmin,
    });
    return;
  }

  Future<DocumentSnapshot<Object?>> getSpecificUser(String email) async {
    return await db.doc(email).get();
  }

  ///get data specific  user from Repository check if is user or not (Login.dart)
  Future checkUser(String email) async {
    var data;
    await db.doc(email).get().then((value) => {data = value.data()});
    bool userStatus = data["isAdmin"];
    print("user status: $userStatus");
    return userStatus;
  }

}
