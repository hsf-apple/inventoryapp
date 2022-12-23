import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel {
  String? name;
  String? email;
  String? userID;
  String? telNumber;

  UserModel(
      {this.name, this.email, this.userID, this.telNumber});

  //save data to firebase
  Map<String, dynamic> toMap() {
    return {
      'username': name,
      'email': email,
      'userID': userID,
      'telNumber': telNumber,
    };
  }

  //get data from Repository
  factory UserModel.fromFirestore(
          DocumentSnapshot<Map<String, dynamic>> firestore) =>
      UserModel(
        name: firestore.data()!['username'],
        email: firestore.data()!['email'],
        userID: firestore.data()!['userID'],
        telNumber: firestore.data()!['telNumber'],
      );

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        name: json['username'],
        email: json['email'],
        userID: json['userID'],
        telNumber: json['telNumber'],
      );
}

class userModelSQLite extends Equatable {
  final int? id;
  final String username;
  final String telNumber;
  final String email;
  final String userID;

  const userModelSQLite(
      {this.id,
      required this.username,
      required this.telNumber,
      required this.userID,
      required this.email});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'telNumber': telNumber,
      'userID': userID,
      'email': email,
      'id': id
    };
  }

//get data from Repository
  static userModelSQLite fromJSON(Map<String, Object?> json) => userModelSQLite(
      username: json['name'] as String,
      telNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      userID: json['StaffOrUserID'] as String,
      id: json['id'] as int?);

  @override
// TODO: implement props
  List<Object?> get props =>
      [id, username, telNumber, userID, email];
}