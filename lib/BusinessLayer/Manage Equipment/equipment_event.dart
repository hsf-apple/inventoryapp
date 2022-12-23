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

class GetEquipmentAdmin extends EquipmentEvent{
  @override
  List<Object?> get props => [];
}

class GetSpecificEquipmentAdmin extends EquipmentEvent{
  final String serialNo;
  const GetSpecificEquipmentAdmin(this.serialNo);
  @override
  List<Object?> get props => [serialNo];
}

class DeleteEquipment extends EquipmentEvent{
  final String serialNo;
  const DeleteEquipment(this.serialNo);

  @override
  List<Object?> get props => [serialNo];
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

class GetSpecificAcknowledgeDelivery extends EquipmentEvent{
  final String serialNo;
  const GetSpecificAcknowledgeDelivery(this.serialNo);

  @override
  List<Object?> get props => [serialNo];

}

class GetAcknowledgeDelivery extends EquipmentEvent{
  @override
  List<Object?> get props => [];
}

class UpdateAcknowledgmentStatus extends EquipmentEvent{
  final String serialNo;
  final String acknowledgmentDelivery;
  const UpdateAcknowledgmentStatus(this.serialNo, this.acknowledgmentDelivery);

  @override
  List<Object?> get props => throw UnimplementedError();
}




