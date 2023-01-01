import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:inventoryapp/BusinessLayer/Manage%20Equipment/equipment_bloc.dart';
import 'package:inventoryapp/PresentationLayer/Screens/Staff/BottomNavBar/NavBarStaff.dart';
import 'package:inventoryapp/PresentationLayer/Screens/Staff/StaffHomeScreen.dart';

import '../../../BusinessLayer/AuthBloc/auth_bloc.dart';
import '../../../DataLayer/Model/DeliveryModel.dart';
import '../../Service/Notification.dart';

class StaffEquipmentForm extends StatefulWidget {
  const StaffEquipmentForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StaffEquipmentForm();
}

class _StaffEquipmentForm extends State<StaffEquipmentForm> {
  final notifications = AwesomeNotifications();

  final EquipmentBloc equipmentBloc = EquipmentBloc();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _date = TextEditingController();
  final TextEditingController _designationPIC = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final TextEditingController _equipmentName = TextEditingController();
  final TextEditingController _tagNo = TextEditingController();
  final TextEditingController _serialNo = TextEditingController();
  final TextEditingController _model = TextEditingController();
  final TextEditingController _referenceNo = TextEditingController();

  final TextEditingController _transportationFirstDescription =
      TextEditingController();

  String _transportaionFirst = "By Hand";
  String _statusFirst = "Functioning Send for Calibration";
  String _physicalConditionFirst = "Good and Complete with Accessories";

  String _currentMonth = "";

  final String _acknowledgmentStatus = "Pending";

  /// date
  String returnDate = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Add Delivery Form"),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,

          elevation: 0,
          // actions: <Widget>[
          //   TextButton(
          //     style: TextButton.styleFrom(
          //       primary: Colors.white,
          //     ),
          //     onPressed: () {
          //       context.read<AuthBloc>().add(SignOutRequested());
          //     },
          //     child: const Text("Log out"),
          //   )
          // ],
          // flexibleSpace: Container(
          //   decoration: const BoxDecoration(
          //     gradient: LinearGradient(
          //         begin: Alignment.topRight,
          //         end: Alignment.bottomLeft,
          //         colors: <Color>[Colors.blue, Colors.green]),
          //   ),
          // ),
        ),
        body: BlocProvider(
          create: (context) => equipmentBloc,
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          monthField(),
                          const SizedBox(height: 15),
                          dateField(),
                          const SizedBox(height: 15),
                          transportationModeField(),
                          const SizedBox(height: 15),
                          transportationDescriptionField(),
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
                          physicalConditionField(),
                          const SizedBox(height: 15),
                          statusEquipmentField(),
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

                                    String? email = FirebaseAuth
                                        .instance.currentUser?.email;
                                    DeliveryModel deliveryModel = DeliveryModel(
                                      date: returnDate,
                                      month: _currentMonth,
                                      designationPIC: _designationPIC.text,
                                      location: _location.text,
                                      equipmentName: _equipmentName.text,
                                      tagNo: _tagNo.text,
                                      serialNo: _serialNo.text,
                                      model: _model.text,
                                      transportationMode: _transportaionFirst,
                                      physicalCondition:
                                          _physicalConditionFirst,
                                      statusEquipment: _statusFirst,
                                      referenceNo: "",
                                      acknowledgmentStatus:
                                          _acknowledgmentStatus,
                                      userEmail: email,
                                      transportationFirstDescription:
                                          _transportationFirstDescription.text,
                                    );

                                    equipmentBloc
                                        .add(CreateDelivery(deliveryModel));

                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //     const SnackBar(content: Text('Data Added Successfully'),
                                    //       backgroundColor: Colors.green,
                                    //     )
                                    // );
                                    //Active when finish home page
                                    //Navigator.of(context).pop();
                                    // Create a notification after the form is submitted
                                    sendQueryReminderNotification(
                                        deliveryModel);

                                    Navigator.of(context,rootNavigator: false ).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          const NavBarStaff(),
                                        ),
                                            (Route<dynamic> route) => false);

                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent,
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

  Widget monthField() {
    String month = DateFormat.MMMM().format(DateTime.now());

    return DropdownButtonFormField(
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

    // return DateTimePicker(
    //   initialDate: returnDateInitial,
    //   type: DateTimePickerType.date,
    //   firstDate: DateTime(2000),
    //   lastDate: DateTime(2100),
    //   decoration: const InputDecoration(
    //     border: UnderlineInputBorder(),
    //     labelText: "Start Date",
    //   ),
    //   dateLabelText: 'Return Date',
    //   // onChanged: (val) => print(val),
    //   validator: (value) {
    //     if (value == null) {
    //       return 'Please enter date to return the equipments';
    //     }
    //     return null;
    //   },
    //   onSaved: (val) => returnDate = val!,
    // );

    // return TextFormField(
    //   controller: _date,
    //   validator: (value){
    //     if (value == null || value.isEmpty) {
    //       return 'Please enter the field';
    //     }
    //     return null;
    //   },
    //   decoration: const InputDecoration(
    //     label: Text('Date'),
    //   ),
    // );
  }

  DateTime returnDateInitial = DateTime.now();

  Widget dateField() {
    return DateTimePicker(
      initialDate: returnDateInitial,
      type: DateTimePickerType.date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: "Date",
      ),
      dateLabelText: 'Date',
      // onChanged: (val) => print(val),
      validator: (value) {
        if (value == null) {
          return 'Please enter date to return the equipments';
        }
        return null;
      },
      onSaved: (val) => returnDate = val!,
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

  Widget designationPICField() {
    return TextFormField(
      controller: _designationPIC,
      validator: (value) {
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

  Widget transportationModeField() {
    return DropdownButtonFormField(
        validator: (value) {
          if (value == null) {
            return 'Please enter valid transportation ';
          }
          return null;
        },
        decoration: const InputDecoration(
          label: Text('Transportation Mode'),
        ),
        value: _transportaionFirst,
        elevation: 16,
        items: <String>['By Hand', 'Courier']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _transportaionFirst = newValue!;
          });
        });
  }

  Widget transportationDescriptionField() {
    switch (_transportaionFirst) {
      case "Courier":
        return TextFormField(
          controller: _transportationFirstDescription,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the field';
            }
            return null;
          },
          decoration: const InputDecoration(
            label: Text('Consignment Note No'),
          ),
        );
        break;
      default:
        return TextFormField(
          controller: _transportationFirstDescription,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the field';
            }
            return null;
          },
          decoration: const InputDecoration(
            label: Text('Name'),
          ),
        );
    }
  }

  Widget statusEquipmentField() {
    return DropdownButtonFormField(
        isExpanded: true,
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
        items: <String>[
          'Functioning Send for Calibration',
          'Not Functioning Send for Repair',
          'Not Functioning Send for Repair and Calibration'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _statusFirst = newValue!;
          });
        });
  }

  Widget physicalConditionField() {
    return DropdownButtonFormField(
        validator: (value) {
          if (value == null) {
            return 'Please enter valid value';
          }
          return null;
        },
        decoration: const InputDecoration(
          label: Text('Physical Condition'),
        ),
        value: _physicalConditionFirst,
        elevation: 16,
        items: <String>[
          'Good and Complete with Accessories',
          'Good and without Accessories'
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _physicalConditionFirst = newValue!;
          });
        });
  }

  Widget referenceNoField() {
    return TextFormField(
      controller: _referenceNo,
      validator: (value) {
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
