part of 'delivery_bloc.dart';

abstract class DeliveryEvent extends Equatable {
  const DeliveryEvent();
}

/// get  equipment list for specific user
class GetListEquipmentDelivery extends DeliveryEvent{
  const GetListEquipmentDelivery();
  @override
  List<Object?> get props => [];
}

/// get  equipment list for admin (acknowledgment status == pending)
class GetListEquipmentDeliveryAdmin extends DeliveryEvent{
  const GetListEquipmentDeliveryAdmin();
  @override
  List<Object?> get props => [];
}

/// get  equipment list for admin (acknowledgment status == denied)
class GetListEquipmentDeliveryAdminDenied extends DeliveryEvent{
  const GetListEquipmentDeliveryAdminDenied();
  @override
  List<Object?> get props => [];
}

/// get  equipment list for admin (acknowledgment status == approve)
class GetListEquipmentDeliveryAdminApproved extends DeliveryEvent{
  const GetListEquipmentDeliveryAdminApproved();
  @override
  List<Object?> get props => [];
}