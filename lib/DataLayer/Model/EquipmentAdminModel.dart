import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class EquipmentAdminModel{
  String? month;
  String? dateReceive;
  String? equipmentName;
  String? tagNo;
  String? serialNo;
  String? manufacturer;
  String? model;
  String? laboratoryWorks;
  String? confirmationDate;
  String? physicalCondition;
  String? jobNo;
  String? status;
  String? dueDate;
  String? certificateReportNo;
  String? dateReturned;
  String? location;
  // String? userEmail;

  EquipmentAdminModel(
      {this.month,
      this.certificateReportNo,
      this.confirmationDate,
      this.dateReceive,
      this.dateReturned,
      this.dueDate,
      this.equipmentName,
      this.jobNo,
      this.laboratoryWorks,
      this.location,
      this.manufacturer,
      this.model,
      this.physicalCondition,
      this.serialNo,
      this.status,
      this.tagNo,
      // this.userEmail
  });

  Map<String, dynamic> toMap(){
    return{
      "month": month,
      "dateReceive": dateReceive,
      'equipmentName': equipmentName,
      'tagNo': tagNo,
      'serialNo': serialNo,
      'manufacturer': manufacturer,
      'model': model,
      'laboratoryWorks': laboratoryWorks,
      'confirmationDate': confirmationDate,
      'physicalCondition': physicalCondition,
      'jobNo': jobNo,
      'station': status,
      'dueDate': dueDate,
      'certificateReportNo': certificateReportNo,
      'dateReturned': dateReturned,
      'location': location,
      // 'userEmail': userEmail,
    };
  }

  factory EquipmentAdminModel.fromFirestore(
      DocumentSnapshot<Map<String,dynamic>> firestore) =>
      EquipmentAdminModel(
          month: firestore.data()!['month'],
          certificateReportNo: firestore.data()!['certificateReportNo'],
          confirmationDate: firestore.data()!['confirmationDate'],
          dateReceive: firestore.data()!['dateReceive'],
          dateReturned: firestore.data()!['dateReturned'],
          dueDate: firestore.data()!['dueDate'],
          equipmentName: firestore.data()!['equipmentName'],
          jobNo: firestore.data()!['jobNo'],
          laboratoryWorks: firestore.data()!['laboratoryWorks'],
          location: firestore.data()!['location'],
          manufacturer: firestore.data()!['manufacturer'],
          model: firestore.data()!['model'],
          physicalCondition: firestore.data()!['physicalCondition'],
          serialNo: firestore.data()!['serialNo'],
          status: firestore.data()!['status'],
          tagNo: firestore.data()!['tagNo'],

  );

  static EquipmentAdminModel fromJson(Map<String, dynamic> json) => EquipmentAdminModel(
      month: json['month'],
      certificateReportNo: json['certificateReportNo'],
      confirmationDate: json['confirmationDate'],
      dateReceive: json['dateReceive'],
      dateReturned: json['dateReturned'],
      dueDate: json['dueDate'],
      equipmentName: json['equipmentName'],
      jobNo: json['jobNo'],
      laboratoryWorks: json['laboratoryWorks'],
      location: json['location'],
      manufacturer: json['manufacturer'],
      model: json['model'],
      physicalCondition: json['physicalCondition'],
      serialNo: json['serialNo'],
      status: json['status'],
      tagNo: json['tagNo'],
      // userEmail: json['userEmail']
  );
}