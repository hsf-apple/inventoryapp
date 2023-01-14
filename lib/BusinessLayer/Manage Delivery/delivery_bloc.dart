import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../DataLayer/Model/DeliveryModel.dart';
import '../../DataLayer/Model/EquipmentAdminModel.dart';
import '../../DataLayer/Provider/EquipmentProver/EquipmentProvider.dart';

part 'delivery_event.dart';
part 'delivery_state.dart';

class DeliveryBloc extends Bloc<DeliveryEvent, DeliveryState> {
  DeliveryBloc() : super(DeliveryInitial()) {
    final EquipmentProvider equipmentProvider = EquipmentProvider();
    on<DeliveryEvent>((event, emit) {
      // TODO: implement event handler
    });
    /// display list of Equipment for specific user
    on<GetListEquipmentDelivery>((event, emit) async {
      var listEquipment = await equipmentProvider.fetchEquipmentListSpecificUser();
      emit(ListEquipmentUserLoadDelivery(listEquipment));
    });

    /// display list of Equipment for admin ( acknowledgment Status = "Pending")
    on<GetListEquipmentDeliveryAdmin>((event, emit) async {
      var listEquipment = await equipmentProvider.getAllListDeliveryStatusForAdmin();
      emit(ListEquipmentDeliveryAdminLoad(listEquipment));
    });

    /// display list of Equipment for admin ( acknowledgment Status = "denied")
    on<GetListEquipmentDeliveryAdminDenied>((event, emit) async {
      var listEquipment = await equipmentProvider.getAllListDeliveryStatusForAdminDenied();
      emit(ListEquipmentDeliveryAdminLoad(listEquipment));
    });

    /// display list of Equipment for admin ( acknowledgment Status = "Approve")
    on<GetListEquipmentDeliveryAdminApproved>((event, emit) async {
      var listEquipment = await equipmentProvider.getAllListDeliveryStatusForAdminApproved();
      emit(ListEquipmentDeliveryAdminLoad(listEquipment));
    });

  }
}
