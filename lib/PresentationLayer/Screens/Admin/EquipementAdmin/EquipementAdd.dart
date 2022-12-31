import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../BusinessLayer/Manage Equipment/equipment_bloc.dart';
import '../../../../DataLayer/Model/EquipmentAdminModel.dart';
import 'EquipementList.dart';

class EquipmentAdd extends StatefulWidget {
  const EquipmentAdd({Key? key}) : super(key: key);

  @override
  State<EquipmentAdd> createState() => _EquipmentAddState();
}

class _EquipmentAddState extends State<EquipmentAdd> {
  final _formKey = GlobalKey<FormState>();

  final EquipmentBloc equipmentBloc = EquipmentBloc();


  final TextEditingController _equipmentName = TextEditingController();
  final TextEditingController _tagNo = TextEditingController();
  final TextEditingController _serialNo = TextEditingController();
  final TextEditingController _manufacturer = TextEditingController();
  final TextEditingController _model = TextEditingController();
  final TextEditingController _laboratoryWorks = TextEditingController();
  final TextEditingController _confirmationDate = TextEditingController();
  final TextEditingController _physicalCondition = TextEditingController();
  final TextEditingController _jobNo = TextEditingController();
  final TextEditingController _certificateReportNo = TextEditingController();
  final TextEditingController _location = TextEditingController();

  String _currentMonth = "";

  /// date
  String dateReceived ="";
  String confirmationDate ="";
  String dueDate ="";
  String dateReturned = "";

  String status = "In Progress";



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: CustomScrollView(slivers: [
        const SliverAppBar(
          leading: BackButton(color: Colors.black),
          floating: true,
          snap: true,
          title: Text(
            "Add Equipment",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Card(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 10,
                        shadowColor: Colors.black,
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                                // const SizedBox(height: 15),
                                // dueDateField(),
                                const SizedBox(height: 15),
                                certificateReportNoField(),
                                const SizedBox(height: 15),
                                dateReturnedField(),
                                const SizedBox(height: 15),
                                locationField(),
                                const SizedBox(height: 15),
                                Material(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
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
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {

                                          _formKey.currentState!.save();

                                          // Parse the string into a DateTime object
                                          final date = DateFormat('yyyy-MM-dd').parse(confirmationDate);

                                          // Add one year to the date
                                          final newDate = date.add(const Duration(days: 365));

                                          final dateFormatter = DateFormat('yyyy-MM-dd');
                                          print(dateFormatter.format(newDate)); // Output: 2023-01-03


                                          EquipmentAdminModel
                                              equipmentAdminModel =
                                              EquipmentAdminModel(
                                            month: _currentMonth,
                                            dateReceive: dateReceived,
                                            equipmentName: _equipmentName.text,
                                            tagNo: _tagNo.text,
                                            serialNo: _serialNo.text,
                                            manufacturer: _manufacturer.text,
                                            model: _model.text,
                                            laboratoryWorks:
                                                _laboratoryWorks.text,
                                            confirmationDate:
                                            confirmationDate,
                                            physicalCondition:
                                                _physicalCondition.text,
                                            jobNo: _jobNo.text,
                                            status: status,
                                            dueDate: dateFormatter.format(newDate).toString(),
                                            certificateReportNo:
                                                _certificateReportNo.text,
                                            dateReturned: dateReturned,
                                            location: _location.text,
                                          );

                                          equipmentBloc.add(
                                              CreateEquipmentAdmin(
                                                  equipmentAdminModel));

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content:
                                                Text('Data Added Successfully'),
                                            backgroundColor: Colors.black
                                            ,
                                          ));
                                          //Active when finish home page
                                          //Navigator.of(context).pop();

                                          // Navigator.of(context,rootNavigator: false ).pushAndRemoveUntil(
                                          //     MaterialPageRoute(
                                          //       builder: (BuildContext context) =>
                                          //       const EquipmentList(),
                                          //     ),
                                          //         (Route<dynamic> route) => false);


                                        Navigator.pop(context);

                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          fixedSize: const Size(300, 60),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25))),
                                      child: const Text('Confirm'),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        )))
              ],
            ),
          )
        ]))
      ]),
    ));
  }

  //////////////////////Text Field///////////////////////////
  Widget monthField() {
    String month = DateFormat.MMMM().format(DateTime.now());

    return  DropdownButtonFormField(
      validator: (value) {
        if (value == null) {
          return 'Please enter valid month';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Month'),
      ),
      value: month,
      elevation: 16,
      items: <String>[
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _currentMonth = newValue!;
        });
      },
      onSaved: (newValue) => _currentMonth = newValue!,
    );
  }

  Widget dateReceiveField() {
    DateTime returnDateInitial = DateTime.now();
    return DateTimePicker(
      initialDate: returnDateInitial,
      type: DateTimePickerType.date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: "Date received",
      ),
      dateLabelText: 'Date received ',
      // onChanged: (val) => print(val),
      validator: (value) {
        if (value == null) {
          return 'Please enter Date received';
        }
        return null;
      },
      onSaved: (val) => dateReceived = val!,
    );
  }

  Widget equipmentNameField() {
    return TextFormField(
      controller: _equipmentName,
      validator: (value) {
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

  Widget tagNoField() {
    return TextFormField(
      controller: _tagNo,
      validator: (value) {
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

  Widget serialNoField() {
    return TextFormField(
      controller: _serialNo,
      validator: (value) {
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

  Widget manufacturerField() {
    return TextFormField(
      controller: _manufacturer,
      validator: (value) {
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

  Widget modelField() {
    return TextFormField(
      controller: _model,
      validator: (value) {
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

  Widget laboratoryWorksField() {
    return TextFormField(
      controller: _laboratoryWorks,
      validator: (value) {
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

  Widget confirmationDateField() {
    DateTime returnDateInitial1 = DateTime.now();
    return DateTimePicker(
      initialDate: returnDateInitial1,
      type: DateTimePickerType.date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: "Confirmation date for calibration/ Repair",
      ),
      dateLabelText: 'Confirmation date for calibration/ Repair ',
      // onChanged: (val) => print(val),
      validator: (value) {
        if (value == null) {
          return 'Please enter Confirmation date for calibration/ Repair';
        }
        return null;
      },
      onSaved: (val) => confirmationDate = val!,
    );
  }

  Widget physicalConditionField() {
    return TextFormField(
      controller: _physicalCondition,
      validator: (value) {
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

  Widget jobNoField() {
    return TextFormField(
      controller: _jobNo,
      validator: (value) {
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

  Widget statusField() {
    return DropdownButtonFormField(
        isExpanded: true,
        validator: (value) {
          if (value == null) {
            return 'Please enter valid status';
          }
          return null;
        },
        decoration: const InputDecoration(
          label: Text('Status'),
        ),
        value: status,
        elevation: 16,
        items: <String>['In Progress', 'Pending', 'Complete']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue){
          setState(() {
            status = newValue!;
          });
        }
    );
  }

  Widget dueDateField() {
    DateTime returnDateInitial2 = DateTime.now();
    return DateTimePicker(
      initialDate: returnDateInitial2,
      type: DateTimePickerType.date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: "Due Date of Calibration",
      ),
      dateLabelText: 'Due Date of Calibration',
      // onChanged: (val) => print(val),
      validator: (value) {
        if (value == null) {
          return 'Please enter Due Date of Calibration';
        }
        return null;
      },
      onSaved: (val) => dueDate = val!,
    );
  }

  Widget certificateReportNoField() {
    return TextFormField(
      controller: _certificateReportNo,
      validator: (value) {
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

  Widget dateReturnedField() {
    DateTime returnDateInitial3 = DateTime.now();
    return DateTimePicker(
      initialDate: returnDateInitial3,
      type: DateTimePickerType.date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: "Date Returned to User",
      ),
      dateLabelText: 'Date Returned to User',
      // onChanged: (val) => print(val),
      validator: (value) {
        if (value == null) {
          return 'Please enter Date Returned to User';
        }
        return null;
      },
      onSaved: (val) => dateReturned = val!,
    );
  }

  Widget locationField() {
    return TextFormField(
      controller: _location,
      validator: (value) {
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
