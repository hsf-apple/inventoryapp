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

  ///////////////////////////// Delivery /////////////////////////////////////
  CollectionReference deliveryDB = FirebaseFirestore.instance.collection("delivery");

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

  Future<void> acknowledgmentDelivery(DeliveryModel deliveryModel) async{
    await deliveryDB.doc(deliveryModel.serialNo).update({
      "acknowledgmentStatus": deliveryModel.acknowledgmentStatus,
    });
    return;
  }
}