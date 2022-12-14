
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
            // child: BlocProvider(
            //   create: (context){
            //     equipmentBloc.add(event);
            //   },
            // ),
          ),
        ),
    );
  }

}