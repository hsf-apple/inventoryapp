part of 'equipment_bloc.dart';

abstract class EquipmentState extends Equatable {
  const EquipmentState();
}

class EquipmentInitial extends EquipmentState {
  @override
  List<Object> get props => [];
}

class EquipmentLoading extends EquipmentState{
  @override
  List<Object> get props => [];
}

class EquipmentLoaded extends EquipmentState{
  final DocumentSnapshot<Object?> equipmentData;
  const EquipmentLoaded(this.equipmentData);

  @override
  List<Object?> get props => [equipmentData];
}

class DeliveryLoaded extends EquipmentState{
  final DocumentSnapshot<Object?> deliveryData;
  const DeliveryLoaded(this.deliveryData);

  @override
  List<Object?> get props => [deliveryData];
}


/// user -----------------------------------

/// get  equipment list for specific user
class ListEquipmentUserLoad extends EquipmentState{
  final List<DeliveryModel> equipmentModel;
   const ListEquipmentUserLoad(this.equipmentModel);
  @override
  List<Object?> get props => [equipmentModel];
}



/// get  specific equipment when user scan the qr code
class DisplaySpecificEquipmentQRCode extends EquipmentState{
  final  specificEquipmentDetails;
  const DisplaySpecificEquipmentQRCode(this.specificEquipmentDetails);

  @override
  List<Object?> get props => [specificEquipmentDetails];
}


class EquipmentError extends EquipmentState{
  @override
  List<Object> get props => [];
}


class StatusResultQRCodeLoaded extends EquipmentState
{
  final bool value;

  const StatusResultQRCodeLoaded( this.value);

  @override
  List<Object> get props => [value];
}

///-------------------admin--------------


/// get  equipment list for admin
class ListEquipmentLoadAdmin extends EquipmentState{
  final List<EquipmentAdminModel> equipmentModel;
  const ListEquipmentLoadAdmin(this.equipmentModel);
  @override
  List<Object?> get props => [equipmentModel];
}
