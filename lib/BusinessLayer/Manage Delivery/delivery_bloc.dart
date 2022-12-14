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
  }
}
