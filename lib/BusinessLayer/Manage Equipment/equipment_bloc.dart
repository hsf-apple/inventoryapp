import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:inventoryapp/DataLayer/Repository/EquipmentRepository.dart';

import '../../DataLayer/Model/DeliveryModel.dart';
import '../../DataLayer/Model/EquipmentAdminModel.dart';
import '../../DataLayer/Provider/EquipmentProver/EquipmentProvider.dart';

part 'equipment_event.dart';
part 'equipment_state.dart';

class EquipmentBloc extends Bloc<EquipmentEvent, EquipmentState> {
  EquipmentBloc() : super(EquipmentInitial()) {
    final EquipmentRepository equipmentRepository = EquipmentRepository();
    final EquipmentProvider equipmentProvider = EquipmentProvider();

    on<CreateEquipmentAdmin>((event, emit) async {
      await equipmentRepository.addEquipment(event.equipmentAdminModel);
    });

    on<UpdateEquipmentAdmin>((event, emit) async{
      await equipmentRepository.updateEquipment(event.equipmentAdminModel, event.serialNoValue);
    });

    /// display list of Equipment for admin
    on<GetListEquipmentAdmin>((event, emit) async {
      var listEquipment = await equipmentProvider.fetchEquipmentListAdmin();
      emit(ListEquipmentLoadAdmin(listEquipment));
    });

    ///delete specific equipment for admin
    on<DeleteEquipmentAdmin>((event, emit) async {
      await equipmentProvider.deleteEquipmentAdmin(event.serialNo);

      var listEquipment = await equipmentProvider.fetchEquipmentListAdmin();
      emit(ListEquipmentLoadAdmin(listEquipment));
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
      // final listAcknowledge = await assignmentProvider.getAssignmentDateData(event.userId, event.dueDate);
      // emit(GetAssignmentState(listAssignment));
    });
    // create a provider to get the data from firstore

///----------------------------user --------------------------------------

    ///save data to database  when user add the delivery form
    on<AddDeliveryForm>((event, emit) async {
      await equipmentRepository.addDelivery(event.deliveryModel);
    });

    /// display list of Equipment for specific user
    on<GetListEquipment>((event, emit) async {
      var listEquipment = await equipmentProvider.fetchEquipmentListSpecificUser();
      emit(ListEquipmentUserLoad(listEquipment));
    });

    /// display specific data from database
    on<GetSpecificEquipment>((event, emit) async {
      var listEquipment = await equipmentProvider.getSpecificEquipmentAfterQRCode(event.equipmentName);

      emit(DisplaySpecificEquipmentQRCode(listEquipment));
    });


    on<GetSpecificEquipmentMainPageBool>((event, emit) async {


      bool checkEquipment = await EquipmentRepository().checkSpecificEquipment(event.equipmentName);


      switch(checkEquipment) {
        case true:
          emit(const StatusResultQRCodeLoaded(true));
          break;
        default:
          emit(const StatusResultQRCodeLoaded(false));
      }

      //
      // if(event.equipmentName == "Unknown")
      // {
      //   emit(const StatusResultQRCodeLoaded(false));
      // }
      // else
      // {
      //   var listEquipment = equipmentProvider.getSpecificEquipment(event.equipmentName);
      //   if(await listEquipment.isEmpty)
      //   {
      //     emit(const StatusResultQRCodeLoaded(false));
      //   }
      //   else
      //   {
      //     emit(const StatusResultQRCodeLoaded(true));
      //   }
      // }


    });

  }
}
