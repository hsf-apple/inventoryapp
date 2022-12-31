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
      'serialNo': equipmentAdminModel.serialNo,
      'manufacturer': equipmentAdminModel.manufacturer,
      'model': equipmentAdminModel.model,
      'laboratoryWorks': equipmentAdminModel.laboratoryWorks,
      'confirmationDate': equipmentAdminModel.confirmationDate,
      'physicalCondition': equipmentAdminModel.physicalCondition,
      'jobNo': equipmentAdminModel.jobNo,
      'status': equipmentAdminModel.status,
      'dueDate': equipmentAdminModel.dueDate,
      'certificateReportNo': equipmentAdminModel.certificateReportNo,
      'dateReturned': equipmentAdminModel.dateReturned,
      'location': equipmentAdminModel.location,
    });
    return;
  }

  Future<void> updateEquipment(EquipmentAdminModel equipmentAdminModel,String serialNoValue) async {
    if( equipmentAdminModel.serialNo != serialNoValue) {
      // Get a reference to the old document
      final oldDocRef = equipmentAdminDB.doc(serialNoValue);
      await oldDocRef.delete();

      await equipmentAdminDB.doc(equipmentAdminModel.serialNo).set({
        "month": equipmentAdminModel.month,
        "dateReceive": equipmentAdminModel.dateReceive,
        'equipmentName': equipmentAdminModel.equipmentName,
        'tagNo': equipmentAdminModel.tagNo,
        'serialNo': equipmentAdminModel.serialNo,
        'manufacturer': equipmentAdminModel.manufacturer,
        'model': equipmentAdminModel.model,
        'laboratoryWorks': equipmentAdminModel.laboratoryWorks,
        'confirmationDate': equipmentAdminModel.confirmationDate,
        'physicalCondition': equipmentAdminModel.physicalCondition,
        'jobNo': equipmentAdminModel.jobNo,
        'status': equipmentAdminModel.status,
        'dueDate': equipmentAdminModel.dueDate,
        'certificateReportNo': equipmentAdminModel.certificateReportNo,
        'dateReturned': equipmentAdminModel.dateReturned,
        'location': equipmentAdminModel.location,
      });
    }
    else
      {
        await equipmentAdminDB.doc(equipmentAdminModel.serialNo).update({
          "month": equipmentAdminModel.month,
          "dateReceive": equipmentAdminModel.dateReceive,
          'equipmentName': equipmentAdminModel.equipmentName,
          'tagNo': equipmentAdminModel.tagNo,
          'serialNo': equipmentAdminModel.serialNo,
          'manufacturer': equipmentAdminModel.manufacturer,
          'model': equipmentAdminModel.model,
          'laboratoryWorks': equipmentAdminModel.laboratoryWorks,
          'confirmationDate': equipmentAdminModel.confirmationDate,
          'physicalCondition': equipmentAdminModel.physicalCondition,
          'jobNo': equipmentAdminModel.jobNo,
          'status': equipmentAdminModel.status,
          'dueDate': equipmentAdminModel.dueDate,
          'certificateReportNo': equipmentAdminModel.certificateReportNo,
          'dateReturned': equipmentAdminModel.dateReturned,
          'location': equipmentAdminModel.location,
        });
      }
    return;
  }

  ///////////////////////////// Delivery /////////////////////////////////////
  CollectionReference deliveryDB = FirebaseFirestore.instance.collection(
      "delivery");

  Future<void> addDelivery(DeliveryModel deliveryModel) async {
    await deliveryDB.doc(deliveryModel.serialNo).set({
      "month":deliveryModel.month,
      "date": deliveryModel.date,
      'transportationMode': deliveryModel.transportationMode,
      'transportationFirstDescription': deliveryModel.transportationFirstDescription,
      "designationPIC": deliveryModel.designationPIC,
      'location': deliveryModel.location,
      'equipmentName': deliveryModel.equipmentName,
      'tagNo': deliveryModel.tagNo,
      'serialNo': deliveryModel.serialNo,
      'model': deliveryModel.model,
      'physicalCondition': deliveryModel.physicalCondition,
      'statusEquipment': deliveryModel.statusEquipment,
      'referenceNo': deliveryModel.referenceNo,
      "acknowledgmentStatus": deliveryModel.acknowledgmentStatus,
      "userEmail":deliveryModel.userEmail,
      "acknowledgmentReceipt":'',
      "acknowledgmentReceiptName": '',
      "acknowledgmentReceiptDate":'',
    });
    return;
  }

  Future<void> updateDelivery(DeliveryModel deliveryModel) async {
    await deliveryDB.doc(deliveryModel.serialNo).update({
      'referenceNo': deliveryModel.referenceNo,
      "acknowledgmentStatus": deliveryModel.acknowledgmentStatus,
      "acknowledgmentReceipt":deliveryModel.acknowledgmentReceipt,
      "acknowledgmentReceiptName": deliveryModel.acknowledgmentReceiptName,
      "acknowledgmentReceiptDate": deliveryModel.acknowledgmentReceiptDate,
    });
    return;
  }

  Future<void> acknowledgmentDelivery(DeliveryModel deliveryModel) async {
    await deliveryDB.doc(deliveryModel.serialNo).update({
      "acknowledgmentStatus": deliveryModel.acknowledgmentStatus,
    });
    return;
  }

  ///get list of all equipment (delivery model )  from specific user
  Future<List<DeliveryModel>> getAllEquipmentSpecificLab() async
  {
    String? email = FirebaseAuth.instance.currentUser?.email;
    List<DeliveryModel> equipmentLab = [];
    try {
      final value = await FirebaseFirestore.instance.collection(
          "delivery").get();
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

  ///get list of all equipment from specific user
  Future<List<DeliveryModel>> getAllListDeliveryStatusForAdmin() async
  {
    List<DeliveryModel> equipmentLab = [];
    try {
      final value = await FirebaseFirestore.instance.collection(
          "delivery").get();
      for (var value in value.docs) {
        var details = value.data();

        if (details["acknowledgmentStatus"] == "Pending") {
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


  ///get real-time data from firestore for staff main page
  Stream<QuerySnapshot> dataStream() {
    String? email = FirebaseAuth.instance.currentUser?.email;
    return FirebaseFirestore.instance.collection('delivery').where("userEmail", isEqualTo: email).snapshots();
  }



  ///display specific equipment when user scan the qr code
  Stream<DocumentSnapshot<Object?>> getSpecificEquipment(String serialNo) {
    Stream<DocumentSnapshot> courseDocStream = equipmentAdminDB.doc(serialNo)
        .snapshots();


    return courseDocStream;
  }


  Future<bool> checkSpecificEquipment(String serialNo)
  async {
    // List<String> allLabData =[];
    // final listLabCollection =  FirebaseFirestore.instance.collection("ListEquipment");
    // await listLabCollection.where('Equipment',arrayContains: serialNo).get().then((value) {
    //   value.docs.forEach((result) {
    //
    //     allLabData.add(result.data()["Equipment"].toString());
    //     print(result.data());
    //   });
    // });
    // if(allLabData.isEmpty)
    // {
    //   return false;
    // }
    // else
    // {
    //   return true;
    // }

    try {
      DocumentSnapshot snapshot = await equipmentAdminDB.doc(serialNo).get();
      if (snapshot.exists) {
        return true;
      }
      else
        {
          return false;
        }
    } catch (e) {
      print("Error: $e");
    }

    return false;

  }

  ///display specific equipment when user scan the qr code
  Future getSpecificEquipmentAfterQRCode(String serialNo) async {

    final document = equipmentAdminDB.doc(serialNo);

    // Get the document snapshot
    final snapshot = await document.get();

    return snapshot;
  }

  ///---------------------------------admin

  ///get list of all equipment for admin
  Future<List<EquipmentAdminModel>> getAllEquipmentAdmin() async
  {
    String? email = FirebaseAuth.instance.currentUser?.email;
    List<EquipmentAdminModel> equipmentLab = [];
    try {
      final value = await FirebaseFirestore.instance.collection(
          "equipmentAdmin").get();
      for (var value in value.docs) {
        equipmentLab.add(EquipmentAdminModel.fromJson(value.data()));

      }
      return equipmentLab;
    } on FirebaseException catch (e) {
      return equipmentLab;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

///delete specific document from collection ('equipmentAdmin')
  Future<void> deleteEquipmentAdmin(String serialNo ) async
  {

    await FirebaseFirestore.instance.collection('equipmentAdmin').doc(serialNo).delete();

  }
}
