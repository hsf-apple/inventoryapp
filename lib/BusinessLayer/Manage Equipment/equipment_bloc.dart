import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:inventoryapp/DataLayer/Repository/EquipmentRepository.dart';

import '../../DataLayer/Model/DeliveryModel.dart';
import '../../DataLayer/Model/EquipmentAdminModel.dart';

part 'equipment_event.dart';
part 'equipment_state.dart';

class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  EquipmentBloc() : super(EquipmentInitial()) {
    final EquipmentRepository equipmentRepository = EquipmentRepository();

    on<CreateEquipmentAdmin>((event, emit) async {
      await equipmentRepository.addEquipment(event.equipmentAdminModel);
    });

    on<UpdateEquipmentAdmin>((event, emit) async{
      await equipmentRepository.updateEquipment(event.equipmentAdminModel);
    });

    on<DeleteEquipment>((event, emit) async{
      await equipmentRepository.deleteEquipment(event.serialNo);
    });

    on<GetEquipmentAdmin>((event, emit) async {
      emit(EquipmentLoading());
      final listEquipment = await equipmentRepository.getEquipment();
      emit(ListEquipmentAdminState(listEquipment));
    });

    on<GetSpecificEquipmentAdmin>((event, emit) async{
      emit(EquipmentLoading());
      final specificEquipment = await equipmentRepository.getSpecificEquipmentAdmin(event.serialNo);
      emit(SpecificEquipmentLoaded(specificEquipment));
    });

    //////////////////////////////////Delivery ////////////////////////////////
    on<CreateDelivery>((event, emit) async {
      await equipmentRepository.addDelivery(event.deliveryModel);
    });

    on<UpdateDelivery>((event, emit) async {
      await equipmentRepository.updateDelivery(event.deliveryModel);
    });

    on<GetAcknowledgeDelivery>((event, emit) async {
      emit(EquipmentLoading());
      final listAcknowledge = await equipmentRepository.getAcknowledgmentList();
      emit(ListAcknowledgeDeliveryState(listAcknowledge));
    });

    on<UpdateAcknowledgmentStatus>((event, emit) async {
      await equipmentRepository.acknowledgmentDelivery(event.serialNo, event.acknowledgmentDelivery);
    });


  }
}