import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../BusinessLayer/Manage Equipment/equipment_bloc.dart';
import '../../../../DataLayer/Model/EquipmentAdminModel.dart';
import 'EquipementList.dart';

class EquipmentUpdate extends StatefulWidget {
  const EquipmentUpdate({Key? key}) : super(key: key);

  @override
  State<EquipmentUpdate> createState() => _EquipmentUpdateState();
}

class _EquipmentUpdateState extends State<EquipmentUpdate> {
  final _formKey = GlobalKey<FormState>();

  final EquipmentBloc equipmentBloc = EquipmentBloc();

  String equipmentNameFinal = "" ;
  String tagNoFinal = "" ;
  String serialNoFinal = "" ;
  String manufacturerFinal = "" ;
  String modelFinal = "" ;
  String laboratoryWorksFinal = "" ;
  String physicalConditionFinal = "" ;
  String jobNoFinal = "" ;
  String certificateReportNoFinal = "" ;
  String locationFinal = "" ;
  String dateReceiveFinal = "" ;
  String monthFinal = "" ;
  String statusFinal = "" ;
  String dueDateFinal = "" ;
  String dateReturnedFinal = "" ;
  String confirmationDateFinal = "";

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)?.settings.arguments as Map;
    String month = todo['month'];
    String dateReceive = todo['dateReceive'];
    String equipmentName = todo['equipmentName'];
    String tagNo = todo['tagNo'];
    String serialNo = todo['serialNo'];
    String manufacturer = todo['manufacturer'];
    String model = todo['model'];
    String laboratoryWorks = todo['laboratoryWorks'];
    String confirmationDate = todo['confirmationDate'];
    String physicalCondition = todo['physicalCondition'];
    String jobNo = todo['jobNo'];
    String status = todo['status'];
    String dueDate = todo['dueDate'];
    String certificateReportNo = todo['certificateReportNo'];
    String dateReturned = todo['dateReturned'];
    String location = todo['location'];




    return SafeArea(
        child: Scaffold(
          body: CustomScrollView(slivers: [
            const SliverAppBar(
              leading: BackButton(color: Colors.black),
              floating: true,
              snap: true,
              title: Text(
                "Update Equipment",
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
                                        monthField(month),
                                        const SizedBox(height: 15),
                                        dateReceiveField(dateReceive),
                                        const SizedBox(height: 15),
                                        equipmentNameField(equipmentName),
                                        const SizedBox(height: 15),
                                        tagNoField(tagNo),
                                        const SizedBox(height: 15),
                                        serialNoField(serialNo),
                                        const SizedBox(height: 15),
                                        manufacturerField(manufacturer),
                                        const SizedBox(height: 15),
                                        modelField(model),
                                        const SizedBox(height: 15),
                                        laboratoryWorksField(laboratoryWorks),
                                        const SizedBox(height: 15),
                                        confirmationDateField(confirmationDate),
                                        const SizedBox(height: 15),
                                        physicalConditionField(physicalCondition),
                                        const SizedBox(height: 15),
                                        jobNoField(jobNo),
                                        const SizedBox(height: 15),
                                        statusField(status),
                                        // const SizedBox(height: 15),
                                        // dueDateField(dueDate),
                                        const SizedBox(height: 15),
                                        certificateReportNoField(certificateReportNo),
                                        const SizedBox(height: 15),
                                        dateReturnedField(dateReturned),
                                        const SizedBox(height: 15),
                                        locationField(location),
                                        const SizedBox(height: 15),
                                        Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(25)),
                                            gradient: LinearGradient(
                                              begin: Alignment.topRight,
                                              end: Alignment.bottomLeft,
                                              colors: [
                                                Color.fromARGB(255, 64, 224, 208),
                                                Colors.blue,
                                              ],
                                            ),
                                          ),
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              if (_formKey.currentState!.validate()) {

                                                _formKey.currentState!.save();

                                                // Parse the string into a DateTime object
                                                final date = DateFormat('yyyy-MM-dd').parse(confirmationDateFinal);

                                                // Add one year to the date
                                                final newDate = date.add(const Duration(days: 365));

                                                final dateFormatter = DateFormat('yyyy-MM-dd');
                                                if (kDebugMode) {
                                                  print(dateFormatter.format(newDate));
                                                } // Output: 2023-01-03


                                                EquipmentAdminModel
                                                equipmentAdminModel =
                                                EquipmentAdminModel(
                                                  month: monthFinal,
                                                  dateReceive: dateReceiveFinal,
                                                  equipmentName: equipmentNameFinal,
                                                  tagNo: tagNoFinal,
                                                  serialNo: serialNoFinal,
                                                  manufacturer: manufacturerFinal,
                                                  model: modelFinal,
                                                  laboratoryWorks:
                                                  laboratoryWorksFinal,
                                                  confirmationDate:
                                                  confirmationDateFinal,
                                                  physicalCondition:
                                                  physicalConditionFinal,
                                                  jobNo: jobNoFinal,
                                                  status: statusFinal,
                                                  dueDate: dateFormatter.format(newDate).toString(),
                                                  certificateReportNo:
                                                  certificateReportNoFinal,
                                                  dateReturned: dateReturnedFinal,
                                                  location: locationFinal,
                                                );

                                                equipmentBloc.add(
                                                    UpdateEquipmentAdmin(
                                                        equipmentAdminModel,serialNo ));

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                  content:
                                                  Text('Data Added Successfully'),
                                                  backgroundColor: Colors.black,
                                                ));
                                                //Active when finish home page
                                                //Navigator.of(context).pop();

                                                Navigator.of(context,rootNavigator: false ).pushAndRemoveUntil(
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) =>
                                                      const EquipmentList(),
                                                    ),
                                                        (Route<dynamic> route) => false);

                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                elevation:0,
                                                backgroundColor: Colors.transparent,
                                                fixedSize: const Size(300, 60),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(25))),
                                            child: const Text('Confirm'),
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
  Widget monthField(String month) {


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
      ].map<DropdownMenuItem<String>>((String value1) {
        return DropdownMenuItem<String>(
          value: value1,
          child: Text(value1),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          monthFinal = newValue!;
        });
      },
      onSaved: (newValue) => monthFinal = newValue!,
    );
  }

  Widget dateReceiveField(dateReceive) {

    DateTime date = DateFormat("yyyy-MM-dd").parse(dateReceive);

    return DateTimePicker(
      initialDate: date,
      initialValue: dateReceive,
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
      onSaved: (val) => dateReceiveFinal = val!,
    );
  }

  Widget equipmentNameField(String equipmentName) {
    return TextFormField(
      initialValue: equipmentName,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Equipment Name'),
      ),
      onSaved: (val) => equipmentNameFinal = val!,
    );
  }

  Widget tagNoField(tagNo) {
    return TextFormField(
      initialValue:tagNo,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Tag No.'),
      ),
      onSaved: (val) => tagNoFinal = val!,
    );
  }

  Widget serialNoField(serialNo) {
    return TextFormField(
      initialValue:serialNo,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Serial No.'),
      ),
      onSaved: (val) => serialNoFinal = val!,
    );
  }

  Widget manufacturerField(manufacturer) {
    return TextFormField(
      initialValue:manufacturer,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Manufacturer'),
      ),
      onSaved: (val) => manufacturerFinal = val!,
    );
  }

  Widget modelField(model) {
    return TextFormField(
      initialValue: model,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Model'),
      ),
      onSaved: (val) => modelFinal = val!,

    );
  }

  Widget laboratoryWorksField(laboratoryWorks) {
    return TextFormField(
      initialValue: laboratoryWorks,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Laboratory Works'),
      ),
      onSaved: (val) => laboratoryWorksFinal = val!,
    );
  }

  Widget confirmationDateField(confirmationDate) {

    DateTime date1 = DateFormat("yyyy-MM-dd").parse(confirmationDate);

    return DateTimePicker(
      initialDate: date1,
      initialValue: confirmationDate,
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
      onSaved: (val) => confirmationDateFinal = val!,
    );
  }

  Widget physicalConditionField(physicalCondition) {
    return TextFormField(
      initialValue: physicalCondition,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Physical Condition'),
      ),
      onSaved: (val) => physicalConditionFinal = val!,
    );
  }

  Widget jobNoField(jobNo) {
    return TextFormField(
      initialValue: jobNo,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Job No.'),
      ),
      onSaved: (val) => jobNoFinal = val!,
    );
  }

  Widget statusField(String status) {
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
            .map<DropdownMenuItem<String>>((String value2) {
          return DropdownMenuItem<String>(
            value: value2,
            child: Text(value2),
          );
        }).toList(),
        onChanged: (String? newValue){
          setState(() {
            statusFinal = newValue!;
          });
        },
        onSaved: (newValue) => statusFinal = newValue!,
    );
  }

  Widget dueDateField(dueDate) {
    DateTime date2 = DateFormat("yyyy-MM-dd").parse(dueDate);
    return DateTimePicker(
      initialDate: date2,
      initialValue: dueDate,
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
      onSaved: (val) => dueDateFinal = val!,
    );
  }

  Widget certificateReportNoField(certificateReportNo) {
    return TextFormField(
      initialValue: certificateReportNo,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Certificate No./ Report No.'),
      ),
      onSaved: (val) => certificateReportNoFinal = val!,
    );
  }

  Widget dateReturnedField(dateReturn) {
    DateTime date3 = DateFormat("yyyy-MM-dd").parse(dateReturn);
    return DateTimePicker(
      initialDate: date3,
      initialValue: dateReturn,
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
      onSaved: (val) => dateReturnedFinal = val!,
    );
  }

  Widget locationField(location) {
    return TextFormField(
      initialValue: location,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Location'),
      ),
      onSaved: (val) => locationFinal = val!,
    );
  }
}
