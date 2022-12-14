import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventoryapp/DataLayer/Model/EquipmentAdminModel.dart';

import '../Model/DeliveryModel.dart';

class EquipmentRepository {
  CollectionReference equipmentAdminDB = FirebaseFirestore.instance.collection(
      "equipmentAdmin");

  Future<void> addEquipment(EquipmentAdminModel equipmentAdminModel) async {
    await equipmentAdminDB.doc(equipmentAdminModel.serialNo).set({
      "month": equipmentAdminModel.month,
      "dateReceive": equipmentAdminModel.dateReceive,
      'equipmentName': equipmentAdminModel.equipmentName,
      'tagNo': equipmentAdminModel.tagNo,
      'manufacturer': equipmentAdminModel.manufacturer,
      'model': equipmentAdminModel.model,
      'laboratoryWorks': equipmentAdminModel.laboratoryWorks,
      'confirmationDate': equipmentAdminModel.confirmationDate,
      'physicalCondition': equipmentAdminModel.physicalCondition,
      'jobNo': equipmentAdminModel.jobNo,
      'station': equipmentAdminModel.status,
      'dueDate': equipmentAdminModel.dueDate,
      'certificateReportNo': equipmentAdminModel.certificateReportNo,
      'dateReturned': equipmentAdminModel.dateReturned,
      'location': equipmentAdminModel.location,
    });
    return;
  }

  Future<void> updateEquipment(EquipmentAdminModel equipmentAdminModel) async {
    await equipmentAdminDB.doc(equipmentAdminModel.serialNo).update({
      "month": equipmentAdminModel.month,
      "dateReceive": equipmentAdminModel.dateReceive,
      'equipmentName': equipmentAdminModel.equipmentName,
      'tagNo': equipmentAdminModel.tagNo,
      'manufacturer': equipmentAdminModel.manufacturer,
      'model': equipmentAdminModel.model,
      'laboratoryWorks': equipmentAdminModel.laboratoryWorks,
      'confirmationDate': equipmentAdminModel.confirmationDate,
      'physicalCondition': equipmentAdminModel.physicalCondition,
      'jobNo': equipmentAdminModel.jobNo,
      'station': equipmentAdminModel.status,
      'dueDate': equipmentAdminModel.dueDate,
      'certificateReportNo': equipmentAdminModel.certificateReportNo,
      'dateReturned': equipmentAdminModel.dateReturned,
      'location': equipmentAdminModel.location,
    });
    return;
  }

  ///////////////////////////// Delivery /////////////////////////////////////
  CollectionReference deliveryDB = FirebaseFirestore.instance.collection(
      "delivery");

  Future<void> addDelivery(DeliveryModel deliveryModel) async {
    await deliveryDB.doc(deliveryModel.serialNo).set({
      "date": deliveryModel.date,
      "designationPIC": deliveryModel.designationPIC,
      'location': deliveryModel.location,
      'equipmentName': deliveryModel.equipmentName,
      'tagNo': deliveryModel.tagNo,
      'serialNo': deliveryModel.serialNo,
      'model': deliveryModel.model,
      'transportationMode': deliveryModel.transportationMode,
      'physicalCondition': deliveryModel.physicalCondition,
      'statusEquipment': deliveryModel.statusEquipment,
      'referenceNo': deliveryModel.referenceNo,
      "acknowledgmentStatus": deliveryModel.acknowledgmentStatus,
    });
    return;
  }

  Future<void> updateDelivery(DeliveryModel deliveryModel) async {
    await deliveryDB.doc(deliveryModel.serialNo).update({
      "date": deliveryModel.date,
      "designationPIC": deliveryModel.designationPIC,
      'location': deliveryModel.location,
      'equipmentName': deliveryModel.equipmentName,
      'tagNo': deliveryModel.tagNo,
      'serialNo': deliveryModel.serialNo,
      'model': deliveryModel.model,
      'transportationMode': deliveryModel.transportationMode,
      'physicalCondition': deliveryModel.physicalCondition,
      'statusEquipment': deliveryModel.statusEquipment,
      'referenceNo': deliveryModel.referenceNo,
      "acknowledgmentStatus": deliveryModel.acknowledgmentStatus,
    });
    return;
  }

  Future<void> acknowledgmentDelivery(DeliveryModel deliveryModel) async {
    await deliveryDB.doc(deliveryModel.serialNo).update({
      "acknowledgmentStatus": deliveryModel.acknowledgmentStatus,
    });
    return;
  }

  ///get list of all equipment from specific user
  Future<List<DeliveryModel>> getAllEquipmentSpecificLab() async
  {
    String? email = FirebaseAuth.instance.currentUser?.email;
    List<DeliveryModel> equipmentLab = [];
    try {
      final value = await FirebaseFirestore.instance.collection(
          "DeliveryForm").get();
      for (var value in value.docs) {
        var details = value.data();

        if (details["userEmail"] == email) {
          equipmentLab.add(DeliveryModel.fromJson(value.data()));
        }
      }
      return equipmentLab;
    } on FirebaseException catch (e) {
      return equipmentLab;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  ///display specific equipment when user scan the qr code
  Stream<DocumentSnapshot<Object?>> getSpecificEquipment(String serialNo) {
    Stream<DocumentSnapshot> courseDocStream = equipmentAdminDB.doc(serialNo)
        .snapshots();
    return courseDocStream;
  }

  ///display specific equipment when user scan the qr code
  Future getSpecificEquipmentAfterQRCode(String serialNo) async {

    final document = equipmentAdminDB.doc(serialNo);

    // Get the document snapshot
    final snapshot = await document.get();

    return snapshot;
  }
}