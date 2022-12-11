import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/BusinessLayer/Manage%20Equipment/equipment_bloc.dart';
import 'package:inventoryapp/DataLayer/Model/EquipmentAdminModel.dart';

import '../../../BusinessLayer/AuthBloc/auth_bloc.dart';
import '../../../DataLayer/Model/DeliveryModel.dart';

class AdminEquipmentForm extends StatefulWidget{
  const AdminEquipmentForm({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AdminEquipmentForm();

}

class _AdminEquipmentForm extends State<AdminEquipmentForm>{

  final EquipmentBloc equipmentBloc = EquipmentBloc();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _designationPIC = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _equipmentName =  TextEditingController();
  final TextEditingController _tagNo = TextEditingController();
  final TextEditingController _serialNo = TextEditingController();
  final TextEditingController _model = TextEditingController();
  final TextEditingController _referenceNo = TextEditingController();

  String _transportaionFirst = "Yes";
  String _statusFirst = "Good";
  String _physicalConditionFirst = "Good";
  final String _acknowledgmentStatus = "pending";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Course Work"),
          centerTitle: true,
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
              ),
              onPressed: () {
                context.read<AuthBloc>().add(SignOutRequested());
              },
              child: const Text("Log out"),
            )
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
        body: BlocProvider(
          create: (context) => equipmentBloc,
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     dateField(),
                      const SizedBox(height: 15),
                      designationPICField(),
                      const SizedBox(height: 15),
                      locationField(),
                      const SizedBox(height: 15),
                      equipmentNameField(),
                      const SizedBox(height: 15),
                      tagNoField(),
                      const SizedBox(height: 15),
                      serialNoField(),
                      const SizedBox(height: 15),
                      modelField(),
                      const SizedBox(height: 15),
                      transportationModeField(),
                      const SizedBox(height: 15),
                      physicalConditionField(),
                      const SizedBox(height: 15),
                      statusEquipmentField(),
                      const SizedBox(height: 15),
                      referenceNoField(),
                      const SizedBox(height: 15),
                      Material(
                        elevation: 8,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.greenAccent,
                                Colors.lightBlue
                              ],
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: () async{
                              if(_formKey.currentState!.validate()){

                                DeliveryModel deliveryModel = DeliveryModel(
                                  date: _date.text,
                                  designationPIC: _designationPIC.text,
                                  location: _location.text,
                                  equipmentName: _equipmentName.text,
                                  tagNo: _tagNo.text,
                                  serialNo: _serialNo.text,
                                  model: _model.text,
                                  transportationMode: _transportaionFirst,
                                  physicalCondition: _physicalConditionFirst,
                                  statusEquipment: _statusFirst,
                                  referenceNo: _referenceNo.text,
                                  acknowledgmentStatus: _acknowledgmentStatus,
                                );

                                equipmentBloc.add(CreateDelivery(deliveryModel));

                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Data Added Successfully'),
                                      backgroundColor: Colors.green,
                                    )
                                );
                                //Active when finish home page
                                //Navigator.of(context).pop();


                              }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                fixedSize: const Size(300, 60),
                                shape:
                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                            child: const Text('Confirm'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                )
              ],
            ),
          ),

        ),

      ),
    );
  }

  //////////////////////Text Field///////////////////////////

  Widget dateField(){
    return TextFormField(
      controller: _date,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Date'),
      ),
    );
  }
  Widget equipmentNameField(){
    return TextFormField(
      controller: _equipmentName,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Equipment Name'),
      ),
    );
  }
  Widget tagNoField(){
    return TextFormField(
      controller: _tagNo,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Tag No.'),
      ),
    );
  }
  Widget serialNoField(){
    return TextFormField(
      controller: _serialNo,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Serial No.'),
      ),
    );
  }
  Widget designationPICField(){
    return TextFormField(
      controller: _designationPIC,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('PIC Name & Designation'),
      ),
    );
  }

  Widget modelField(){
    return TextFormField(
      controller: _model,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Model'),
      ),
    );
  }
  Widget transportationModeField(){

    return DropdownButtonFormField(
        validator: (value) {
          if (value == null) {
            return 'Please enter valid status';
          }
          return null;
        },
        decoration: const InputDecoration(
          label: Text('Course Assessment Type'),
        ),
        value: _transportaionFirst,
        elevation: 16,
        items: <String>['Yes', 'No']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue){
          setState(() {
            _transportaionFirst = newValue!;
          });
        }
    );
  }

  Widget statusEquipmentField(){

    return DropdownButtonFormField(
        validator: (value) {
          if (value == null) {
            return 'Please enter valid status';
          }
          return null;
        },
        decoration: const InputDecoration(
          label: Text('Course Assessment Type'),
        ),
        value: _statusFirst,
        elevation: 16,
        items: <String>['Good', 'OK', 'Bad']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue){
          setState(() {
            _statusFirst = newValue!;
          });
        }
    );
  }

  Widget physicalConditionField(){

    return DropdownButtonFormField(
        validator: (value) {
          if (value == null) {
            return 'Please enter valid status';
          }
          return null;
        },
        decoration: const InputDecoration(
          label: Text('Course Assessment Type'),
        ),
        value: _physicalConditionFirst,
        elevation: 16,
        items: <String>['Good', 'OK', 'Bad']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue){
          setState(() {
            _physicalConditionFirst = newValue!;
          });
        }
    );
  }
  Widget referenceNoField(){
    return TextFormField(
      controller: _referenceNo,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Reference No.'),
      ),
    );
  }

  Widget locationField(){
    return TextFormField(
      controller: _location,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Location'),
      ),
    );
  }

}