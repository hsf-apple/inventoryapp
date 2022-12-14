part of 'equipment_bloc.dart';

abstract class EquipmentEvent extends Equatable {
  const EquipmentEvent();
}

class CreateEquipmentAdmin extends EquipmentEvent{
  final EquipmentAdminModel equipmentAdminModel;
  const CreateEquipmentAdmin(this.equipmentAdminModel);

  @override
  List<Object?> get props => [equipmentAdminModel];
}

class UpdateEquipmentAdmin extends EquipmentEvent{
  final EquipmentAdminModel equipmentAdminModel;
  const UpdateEquipmentAdmin(this.equipmentAdminModel);

  @override
  List<Object?> get props => [equipmentAdminModel];
}

//////////////////////// Delivery ////////////////////////////

class CreateDelivery extends EquipmentEvent{
  final DeliveryModel deliveryModel;
  const CreateDelivery(this.deliveryModel);

  @override
  List<Object?> get props => [deliveryModel];
}

class UpdateDelivery extends EquipmentEvent{
  final DeliveryModel deliveryModel;
  const UpdateDelivery(this.deliveryModel);

  @override
  List<Object?> get props => [deliveryModel];
}

class GetAcknowledgeDelivery extends EquipmentEvent{
  final String serialNo;
  const GetAcknowledgeDelivery(this.serialNo);

  @override
  List<Object?> get props => throw UnimplementedError();

}

/// user -----------------------------------

/// get  equipment list for specific user
class GetListEquipment extends EquipmentEvent{
  const GetListEquipment();
  @override
  List<Object?> get props => [];
}

/// get  specific equipment AFTER user scan the qr code
class GetSpecificEquipment extends EquipmentEvent{
  final String equipmentName;
  const GetSpecificEquipment(this.equipmentName);

  @override
  List<Object?> get props => [equipmentName];
}

/// get  specific equipment when user scan the qr code
class GetSpecificEquipmentMainPageBool extends EquipmentEvent{
  final String equipmentName;
  const GetSpecificEquipmentMainPageBool(this.equipmentName);

  @override
  List<Object?> get props => [equipmentName];
}

/// save delivery form details to firestore
class AddDeliveryForm extends EquipmentEvent{
  final DeliveryModel deliveryModel;
  const AddDeliveryForm(this.deliveryModel);
  @override
  List<Object?> get props => [deliveryModel];
}
