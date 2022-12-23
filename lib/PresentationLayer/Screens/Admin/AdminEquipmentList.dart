import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/BusinessLayer/Manage%20Equipment/equipment_bloc.dart';
import 'package:inventoryapp/PresentationLayer/Screens/Admin/EditEquipmentAdmin.dart';
import 'package:inventoryapp/PresentationLayer/Screens/Staff/DeliveryForm.dart';

class AdminEquipmentList extends StatefulWidget{
  const AdminEquipmentList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AdminEquipmentList();
}

class _AdminEquipmentList extends State<AdminEquipmentList>{

  EquipmentBloc equipmentBloc = EquipmentBloc();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Equipment List"),
            centerTitle: true,
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminEquipmentForm()),
                      ).then((_) => setState(() {}));
                    },
                    child: Icon(
                      Icons.add,
                    ),
                  )
              ),
            ],
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
            //continue-------------------------
            margin: const EdgeInsets.all(8),
            child: BlocProvider(
              create: (context){
                equipmentBloc.add(GetEquipmentAdmin());
                return equipmentBloc;
              },
              child: BlocBuilder<EquipmentBloc, EquipmentState>(builder: (context, state){
                if(state is EquipmentInitial){
                  return const Center(child: CircularProgressIndicator(color: Colors.grey));
                }else if(state is EquipmentLoading){
                  return const Center(child: CircularProgressIndicator());
                }else if(state is ListEquipmentAdminState){
                  if(state.model.length == 0){
                    return Center(child: Text("Please Add Equopment"));
                  }else{
                    return _getEquipmentList(context, state.model, equipmentBloc);
                  }
                }else{
                  return const Center(child: Text("No data"));
                }
              }),
            ),
          ),
        )
    );
  }

  Widget _getEquipmentList(BuildContext context, state, equipmentBloc){
    return ListView.builder(
      itemCount: state == null ? 0: state.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){},
            child: Card(
              elevation: 2,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left:8, right: 8),
                                            child: Text(
                                              state[index].serialNo.toString(),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold
                                              ),
                                            )
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
                                            icon: const Icon(Icons.edit),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => const EditEquipmentAdmin(),
                                                      settings: RouteSettings(
                                                        arguments: {
                                                          "serialNo": state[index].serialNo.toString(),
                                                        },
                                                      ))).then((_)=>setState((){
                                                equipmentBloc.add(GetEquipmentAdmin());
                                              }));
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red,),
                                            onPressed: () {
                                              equipmentBloc.add(DeleteEquipment(state[index].id));
                                              setState((){
                                                equipmentBloc.add(GetEquipmentAdmin());
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left:8, right: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Month: ${state[index].month}",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black87
                                      )
                                    ),

                                    Text(
                                        "Certificate Report No.: ${state[index].certificateReportNo}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87
                                        )
                                    ),

                                    Text(
                                        "Confirmation Date: ${state[index].confirmationDate}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87
                                        )
                                    ),

                                    Text(
                                        "Date Receive: ${state[index].dateReceive}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87
                                        )
                                    ),

                                    Text(
                                        "Date Returned: ${state[index].dateReturned}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87
                                        )
                                    ),

                                    Text(
                                        "Due Date: ${state[index].dueDate}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87
                                        )
                                    ),

                                    Text(
                                        "Equipment Name: ${state[index].equipmentName}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87
                                        )
                                    ),

                                    Text(
                                        "Jab No.: ${state[index].jobNo}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87
                                        )
                                    ),

                                    Text(
                                        "Laboratory Works: ${state[index].laboratoryWorks}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87
                                        )
                                    ),

                                    Text(
                                        "Location: ${state[index].location}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87
                                        )
                                    ),

                                    Text(
                                        "Manufacturer: ${state[index].manufacturer}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87
                                        )
                                    ),

                                    Text(
                                        "Model: ${state[index].model}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87
                                        )
                                    ),

                                    Text(
                                        "Physical Condition: ${state[index].physicalCondition}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87
                                        )
                                    ),

                                    Text(
                                        "Status: ${state[index].status}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87
                                        )
                                    ),

                                    Text(
                                        "Tag No: ${state[index].tagNo}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black87
                                        )
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        )
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