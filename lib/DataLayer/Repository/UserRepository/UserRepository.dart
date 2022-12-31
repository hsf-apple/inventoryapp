import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../Model/UserModel/userModel.dart';

class UserRepository {
  CollectionReference db = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(UserModel userModel, String email) async{
    await db.doc(email).set({
      'name': userModel.name,
      'email': userModel.email,
      // 'userID': userModel.userID,
      'telNumber': userModel.telNumber,
      'isAdmin': false,
    });
    return;
  }

  Future<void> updateUser(UserModel userModel, String email) async{

    if( userModel.email != email)
      {
        // Get a reference to the old document
        final oldDocRef = db.doc(email);
        await oldDocRef.delete();

        // Create a new document with the desired ID
        await db.doc(userModel.email).set({
          'name': userModel.name,
          'email': userModel.email,
          'telNumber': userModel.telNumber,
          'isAdmin': false,
        });
        return;
      }
    else
      {
        await db.doc(email).update({
          'name': userModel.name,
          'email': userModel.email,
          'telNumber': userModel.telNumber,
          // 'userID': userModel.userID,
          'isAdmin': userModel.isAdmin,
        });
        return;
      }

  }

  Future<UserModel?> getSpecificUser(String email1) async {
    try {

    final doc =await db.doc(email1).get();
    bool userStatus = doc["isAdmin"];
    String email = doc["email"];
    String name = doc["name"];
    String telNumber = doc["telNumber"];

    UserModel userModel1 = UserModel(
      email: email,
      isAdmin: userStatus,
      name:name,
      telNumber: telNumber
    );

    return userModel1;
  } on FirebaseException catch (e) {
  return null;
  } catch (e) {
  throw Exception(e.toString());
  }


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
