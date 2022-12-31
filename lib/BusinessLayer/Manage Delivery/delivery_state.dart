part of 'delivery_bloc.dart';

abstract class DeliveryState extends Equatable {
  const DeliveryState();
}

class DeliveryInitial extends DeliveryState {
  @override
  List<Object> get props => [];
}

class DeliveryLoading extends DeliveryState {
  @override
  List<Object> get props => [];
}

/// get  equipment list for specific user
class ListEquipmentUserLoadDelivery extends DeliveryState{
  final List<DeliveryModel> equipmentModel;
  const ListEquipmentUserLoadDelivery(this.equipmentModel);
  @override
  List<Object?> get props => [equipmentModel];
}

/// get  equipment list for admin (acknowledgment status == Pending)
class ListEquipmentDeliveryAdminLoad extends DeliveryState{
  final List<DeliveryModel> equipmentModel;
  const ListEquipmentDeliveryAdminLoad(this.equipmentModel);
  @override
  List<Object?> get props => [equipmentModel];
}