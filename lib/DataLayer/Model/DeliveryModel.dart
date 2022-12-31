import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class DeliveryModel{
  String? month;
  String? date;
  String? designationPIC;
  String? location;
  String? equipmentName;
  String? tagNo;
  String? serialNo;
  String? model;
  String? transportationMode;
  String? transportationFirstDescription;
  String? physicalCondition;
  String? statusEquipment;
  String? referenceNo;
  String? acknowledgmentStatus;
  String? acknowledgmentReceipt;
  String? userEmail;
  String? acknowledgmentReceiptName;
  String? acknowledgmentReceiptDate;


  DeliveryModel(
      {this.date,
        this.month,
        this.designationPIC,
        this.location,
        this.equipmentName,
        this.tagNo,
        this.serialNo,
        this.model,
        this.transportationMode,
        this.transportationFirstDescription,
        this.physicalCondition,
        this.statusEquipment,
        this.referenceNo,
        this.acknowledgmentStatus,
        this.acknowledgmentReceipt,
        this.acknowledgmentReceiptName,
        this.acknowledgmentReceiptDate,
      this.userEmail});


  Map<String, dynamic> toMap(){
    return{
      "date": date,
      "month":month,
      "designationPIC": designationPIC,
      "location": location,
      "equipmentName": equipmentName,
      "tagNo": tagNo,
      "serialNo": serialNo,
      "model": model,
      "transportationMode": transportationMode,
      "transportationFirstDescription":transportationFirstDescription,
      "physicalCondition": physicalCondition,
      "statusEquipment": statusEquipment,
      "referenceNo": referenceNo,
      "acknowledgmentStatus": acknowledgmentStatus,
      "userEmail":userEmail,
      "acknowledgmentReceipt":acknowledgmentReceipt,
      "acknowledgmentReceiptName":acknowledgmentReceiptName,
      "acknowledgmentReceiptDate":acknowledgmentReceiptDate,
    };
  }

  factory DeliveryModel.fromFirestore(
      DocumentSnapshot<Map<String,dynamic>> firestore) =>
      DeliveryModel(
          date: firestore.data()!['date'],
          month:firestore.data()!['month'],
          designationPIC: firestore.data()!['designationPIC'],
          location: firestore.data()!['location'],
          equipmentName: firestore.data()!['equipmentName'],
          tagNo: firestore.data()!['tagNo'],
          serialNo: firestore.data()!['serialNo'],
          model: firestore.data()!['model'],
          transportationMode: firestore.data()!['transportationMode'],
          transportationFirstDescription:firestore.data()!['transportationFirstDescription'],
          physicalCondition: firestore.data()!['physicalCondition'],
          statusEquipment: firestore.data()!['statusEquipment'],
          referenceNo: firestore.data()!['referenceNo'],
        acknowledgmentStatus: firestore.data()!["acknowledgmentStatus"],
          userEmail: firestore.data()!['userEmail'],
          acknowledgmentReceipt:firestore.data()!['acknowledgmentReceipt'],
          acknowledgmentReceiptName:firestore.data()!['acknowledgmentReceiptName'],
          acknowledgmentReceiptDate:firestore.data()!['acknowledgmentReceiptDate']
      );

  static DeliveryModel fromJson(Map<String, dynamic> json) => DeliveryModel(
      date: json['date'],
      month: json['month'],
      designationPIC: json['designationPIC'],
      location: json['location'],
      equipmentName: json['equipmentName'],
      tagNo: json['tagNo'],
      serialNo: json['serialNo'],
      model: json['model'],
      transportationMode: json['transportationMode'],
      transportationFirstDescription:json['transportationFirstDescription'],
      physicalCondition: json['physicalCondition'],
      statusEquipment: json['statusEquipment'],
      referenceNo: json['referenceNo'],
      acknowledgmentStatus: json["acknowledgmentStatus"],
      userEmail: json['userEmail'],
      acknowledgmentReceipt:json['acknowledgmentReceipt'],
      acknowledgmentReceiptName:json['acknowledgmentReceiptName'],
      acknowledgmentReceiptDate:json['acknowledgmentReceiptDate']
  );
}