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
