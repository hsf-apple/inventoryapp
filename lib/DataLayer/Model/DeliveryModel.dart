import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class DeliveryModel{
  String? date;
  String? designationPIC;
  String? location;
  String? equipmentName;
  String? tagNo;
  String? serialNo;
  String? model;
  String? transportationMode;
  String? physicalCondition;
  String? statusEquipment;
  String? referenceNo;
  String? acknowledgmentStatus;

  DeliveryModel(
      {this.date,
        this.designationPIC,
        this.location,
        this.equipmentName,
        this.tagNo,
        this.serialNo,
        this.model,
        this.transportationMode,
        this.physicalCondition,
        this.statusEquipment,
        this.referenceNo,
        this.acknowledgmentStatus});

  Map<String, dynamic> toMap(){
    return{
      "date": date,
      "designationPIC": designationPIC,
      "location": location,
      "equipmentName": equipmentName,
      "tagNo": tagNo,
      "serialNo": serialNo,
      "model": model,
      "transportationMode": transportationMode,
      "physicalCondition": physicalCondition,
      "statusEquipment": statusEquipment,
      "referenceNo": referenceNo,
      "acknowledgmentStatus": acknowledgmentStatus,
    };
  }

  factory DeliveryModel.fromFirestore(
      DocumentSnapshot<Map<String,dynamic>> firestore) =>
      DeliveryModel(
          date: firestore.data()!['date'],
          designationPIC: firestore.data()!['designationPIC'],
          location: firestore.data()!['location'],
          equipmentName: firestore.data()!['equipmentName'],
          tagNo: firestore.data()!['tagNo'],
          serialNo: firestore.data()!['serialNo'],
          model: firestore.data()!['model'],
          transportationMode: firestore.data()!['transportationMode'],
          physicalCondition: firestore.data()!['physicalCondition'],
          statusEquipment: firestore.data()!['statusEquipment'],
          referenceNo: firestore.data()!['referenceNo'],
        acknowledgmentStatus: firestore.data()!["acknowledgmentStatus"],
      );

  static DeliveryModel fromJson(Map<String, dynamic> json) => DeliveryModel(
      date: json['date'],
      designationPIC: json['designationPIC'],
      location: json['location'],
      equipmentName: json['equipmentName'],
      tagNo: json['tagNo'],
      serialNo: json['serialNo'],
      model: json['model'],
      transportationMode: json['transportationMode'],
      physicalCondition: json['physicalCondition'],
      statusEquipment: json['statusEquipment'],
      referenceNo: json['referenceNo'],
      acknowledgmentStatus: json["acknowledgmentStatus"],
  );
}