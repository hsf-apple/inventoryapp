
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventoryapp/DataLayer/Model/DeliveryModel.dart';

import '../../Model/EquipmentAdminModel.dart';
import '../../Repository/EquipmentRepository.dart';

class EquipmentProvider {
   final EquipmentRepository equipmentRepository = EquipmentRepository();


  ///specific user ( get equipment list)
  Future<List<DeliveryModel>> fetchEquipmentListSpecificUser() {
    return equipmentRepository.getAllEquipmentSpecificLab();
  }

   Stream<DocumentSnapshot<Object?>> getSpecificEquipment(String serialNo) {
     return equipmentRepository.getSpecificEquipment(serialNo);
   }

   Future getSpecificEquipmentAfterQRCode(String serialNo) {
     return equipmentRepository.getSpecificEquipmentAfterQRCode(serialNo);
   }



}