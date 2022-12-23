
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/BusinessLayer/Manage%20Equipment/equipment_bloc.dart';

class AcknowledgmentDelivery extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AcknowledgmentDelivery();

}

class _AcknowledgmentDelivery extends State<AcknowledgmentDelivery>{

  EquipmentBloc equipmentBloc = EquipmentBloc();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("List Equipment Status (Pending Achknowledgment)"),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: <Color>[Colors.blue, Colors.green]),
              ),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.all(8),
            child: BlocProvider(
              create: (context){
                equipmentBloc.add(GetAcknowledgeDelivery());
                return equipmentBloc;
              },
              child: BlocBuilder<EquipmentBloc, EquipmentState>(builder:(context, state){
                if(state is EquipmentInitial){
                  return const Center(child: CircularProgressIndicator(color: Colors.grey,));
                }else if (state is EquipmentLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ListAcknowledgeDeliveryState) {
                  if(state.model.length == 0){
                    return Center(child: Text("No delivery to Acknowledge"));
                  }else{
                    return _getAcknowledgeList(context, state.model, equipmentBloc);
                  }
                }else{
                  return const Center(child: Text("No data"));
                }
              }),
          ),
        ),
    ));
  }

  Widget _getAcknowledgeList(BuildContext context, state,  equipmentBloc){
    return ListView.builder(
      itemCount: state == null ? 0 : state.length,
      itemBuilder: (context, index){
        return GestureDetector(
          onTap: (){},
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                    child: Text(
                                      state[index].serialNo.toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [

                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.check_circle),
                                    onPressed: () {
                                      equipmentBloc.add(UpdateAcknowledgmentStatus(state[index].serialNo,"Approve"));
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.cancel),
                                    onPressed: () {
                                      equipmentBloc.add(UpdateAcknowledgmentStatus(state[index].serialNo,"Decline"));
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Padding(
                            padding: EdgeInsets.only(left: 8, right: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Date: ${state[index].date}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),

                                Text("PIC Name & Designation: ${state[index].designationPIC}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),

                                Text("Location: ${state[index].location}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),

                                Text("Equipment Name: ${state[index].equipmentName}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),

                                Text("Tag No: ${state[index].tagNo}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),

                                Text("Model: ${state[index].model}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),

                                Text("Transportation Mode: ${state[index].transportationMode}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),

                                Text("Physical Condition: ${state[index].physicalCondition}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),

                                Text("Status Equipment: ${state[index].statusEquipment}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),

                                Text("Reference No.: ${state[index].referenceNo}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black87),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}