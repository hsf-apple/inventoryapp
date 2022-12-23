import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventoryapp/DataLayer/Model/EquipmentAdminModel.dart';

import '../Model/DeliveryModel.dart';

class EquipmentRepository{
  CollectionReference equipmentAdminDB = FirebaseFirestore.instance.collection("equipmentAdmin");

  Future<void> addEquipment(EquipmentAdminModel equipmentAdminModel) async{
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

  Future<void> updateEquipment(EquipmentAdminModel equipmentAdminModel) async{
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

  Future<void> deleteEquipment(String serialNo) async{
    return await equipmentAdminDB.doc(serialNo).delete();
  }

  Future<DocumentSnapshot<Object?>> getSpecificEquipmentAdmin(String serialNo) async {
    return await equipmentAdminDB.doc(serialNo).get();
  }

  Future<List<EquipmentAdminModel>> getEquipment() async{
    List<EquipmentAdminModel> equipmentList = [];

    try{
      final value = await FirebaseFirestore.instance.collection("equipmentAdmin").get();

      for(var value in value.docs){
        equipmentList.add(EquipmentAdminModel.fromJson(value.data()));
      }
      return equipmentList;
    } on FirebaseException catch (e){
      return equipmentList;
    } catch (e){
      throw Exception(e.toString());
    }
  }

  ///////////////////////////// Delivery /////////////////////////////////////
  CollectionReference deliveryDB = FirebaseFirestore.instance.collection("DeliveryForm");

  Future<void> addDelivery(DeliveryModel deliveryModel) async{
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

  Future<void> updateDelivery(DeliveryModel deliveryModel) async{
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

  Future<void> acknowledgmentDelivery(String serialNo, String acknowledgmentStatus) async{
    await deliveryDB.doc(serialNo).update({
      "acknowledgmentStatus": acknowledgmentStatus,
    });
    return;
  }

  Future<List<DeliveryModel>> getAcknowledgmentList() async{
    List<DeliveryModel> deliveryList = [];

    try{
      final value = await FirebaseFirestore.instance.collection("DeliveryForm").get();

      for(var value in value.docs){
        var detail = value.data();

        if(detail['acknowledgmentStatus'] == "Pending"){
          deliveryList.add(DeliveryModel.fromJson(value.data()));
        }
      }
      return deliveryList;
    } on FirebaseException catch (e){
      return deliveryList;
    } catch (e){
      throw Exception(e.toString());
    }
  }
}