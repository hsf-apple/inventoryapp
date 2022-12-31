
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/BusinessLayer/Manage%20Delivery/delivery_bloc.dart';
import 'package:inventoryapp/BusinessLayer/Manage%20Equipment/equipment_bloc.dart';

import 'AcknowledgementDetails.dart';

class AcknowledgmentDelivery extends StatefulWidget{
  const AcknowledgmentDelivery({super.key});

  @override
  State<StatefulWidget> createState() => _AcknowledgmentDelivery();

}

class _AcknowledgmentDelivery extends State<AcknowledgmentDelivery>{

   DeliveryBloc deliveryBloc = DeliveryBloc();

   @override
   void initState() {
     deliveryBloc.add(const GetListEquipmentDeliveryAdmin());
     super.initState();
   }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("List Request Delivery",
              style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: BlocProvider(create:(_) => deliveryBloc, child: BlocBuilder<DeliveryBloc, DeliveryState>(
              builder: (context, state) {
                if (state is DeliveryInitial) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DeliveryLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ListEquipmentDeliveryAdminLoad) {
                  return _UI(context, state.equipmentModel);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),),
        ),
    );
  }
}

Widget _UI(BuildContext context, state) {
  return ListView.builder(
      itemCount: state == null ? 0 : state.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AcknowledgementDetails(),
                    settings: RouteSettings(
                      arguments: {
                        "month": state[index].month.toString(),
                        "date": state[index].date.toString(),
                        "designationPIC": state[index].designationPIC.toString(),
                        "location": state[index].location.toString(),
                        "tagNo": state[index].tagNo.toString(),
                        "equipmentName": state[index].equipmentName.toString(),
                        "serialNo": state[index].serialNo.toString(),
                        "model": state[index].model.toString(),
                        "transportationMode": state[index].transportationMode.toString(),
                        "transportationFirstDescription": state[index].transportationFirstDescription.toString(),
                        "physicalCondition": state[index].physicalCondition.toString(),
                        "statusEquipment": state[index].statusEquipment.toString(),
                        "referenceNo": state[index].referenceNo.toString(),
                        "acknowledgmentStatus": state[index].acknowledgmentStatus.toString(),
                        "acknowledgmentReceipt": state[index].acknowledgmentReceipt.toString(),
                        "userEmail": state[index].date.toString(),
                      },
                    )));
          },
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Text(
                              state[index].equipmentName.toString(),
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Text(state[index].serialNo.toString()),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      });
}
