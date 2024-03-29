import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/BusinessLayer/Manage%20Equipment/equipment_bloc.dart';
import 'package:inventoryapp/DataLayer/Model/EquipmentAdminModel.dart';

import '../../../BusinessLayer/AuthBloc/auth_bloc.dart';

class AdminEquipmentForm extends StatefulWidget{
  const AdminEquipmentForm({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _AdminEquipmentForm();

}

class _AdminEquipmentForm extends State<AdminEquipmentForm>{

  final EquipmentBloc equipmentBloc = EquipmentBloc();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _month = TextEditingController();
  final TextEditingController _dateReceive = TextEditingController();
  final TextEditingController _equipmentName = TextEditingController();
  final TextEditingController _tagNo =  TextEditingController();
  final TextEditingController _serialNo = TextEditingController();
  final TextEditingController _manufacturer = TextEditingController();
  final TextEditingController _model = TextEditingController();
  final TextEditingController _laboratoryWorks = TextEditingController();
  final TextEditingController _confirmationDate = TextEditingController();
  final TextEditingController _physicalCondition = TextEditingController();
  final TextEditingController _jobNo = TextEditingController();
  final TextEditingController _status = TextEditingController();
  final TextEditingController _dueDate = TextEditingController();
  final TextEditingController _certificateReportNo = TextEditingController();
  final TextEditingController _dateReturned = TextEditingController();
  final TextEditingController _location = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.8;
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
                      monthField(),
                      const SizedBox(height: 15),
                      dateReceiveField(),
                      const SizedBox(height: 15),
                      equipmentNameField(),
                      const SizedBox(height: 15),
                      tagNoField(),
                      const SizedBox(height: 15),
                      serialNoField(),
                      const SizedBox(height: 15),
                      manufacturerField(),
                      const SizedBox(height: 15),
                      modelField(),
                      const SizedBox(height: 15),
                      laboratoryWorksField(),
                      const SizedBox(height: 15),
                      confirmationDateField(),
                      const SizedBox(height: 15),
                      physicalConditionField(),
                      const SizedBox(height: 15),
                      jobNoField(),
                      const SizedBox(height: 15),
                      statusField(),
                      const SizedBox(height: 15),
                      dueDateField(),
                      const SizedBox(height: 15),
                      certificateReportNoField(),
                      const SizedBox(height: 15),
                      dateReturnedField(),
                      const SizedBox(height: 15),
                      locationField(),
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

                                EquipmentAdminModel equipmentAdminModel = EquipmentAdminModel(
                                  month: _month.text,
                                  dateReceive: _dateReceive.text,
                                  equipmentName: _equipmentName.text,
                                  tagNo: _tagNo.text,
                                  serialNo: _serialNo.text,
                                  manufacturer: _manufacturer.text,
                                  model: _model.text,
                                  laboratoryWorks: _laboratoryWorks.text,
                                  confirmationDate: _confirmationDate.text,
                                  physicalCondition: _physicalCondition.text,
                                  jobNo: _jobNo.text,
                                  status: _status.text,
                                  dueDate: _dueDate.text,
                                  certificateReportNo: _certificateReportNo.text,
                                  dateReturned: _dateReturned.text,
                                  location: _location.text,
                                );

                                equipmentBloc.add(CreateEquipmentAdmin(equipmentAdminModel));

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
  Widget monthField(){
    return TextFormField(
      controller: _month,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Month'),
      ),
    );
  }

  Widget dateReceiveField(){
    return TextFormField(
      controller: _dateReceive,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Date Receive'),
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
  Widget manufacturerField(){
    return TextFormField(
      controller: _manufacturer,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Manufacturer'),
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
  Widget laboratoryWorksField(){
    return TextFormField(
      controller: _laboratoryWorks,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Laboratory Works'),
      ),
    );
  }
  Widget confirmationDateField(){
    return TextFormField(
      controller: _confirmationDate,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Confirmation Date'),
      ),
    );
  }
  Widget physicalConditionField(){
    return TextFormField(
      controller: _physicalCondition,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Physical Condition'),
      ),
    );
  }
  Widget jobNoField(){
    return TextFormField(
      controller: _jobNo,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Job No.'),
      ),
    );
  }

  Widget statusField(){
    return TextFormField(
      controller: _status,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Status'),
      ),
    );
  }

  Widget dueDateField(){
    return TextFormField(
      controller: _dueDate,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Due Date'),
      ),
    );
  }
  Widget certificateReportNoField(){
    return TextFormField(
      controller: _certificateReportNo,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Certificate No./ Report No.'),
      ),
    );
  }

  Widget dateReturnedField(){
    return TextFormField(
      controller: _dateReturned,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Date Returned'),
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