import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:inventoryapp/PresentationLayer/Screens/Staff/BottomNavBar/NavBarStaff.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../BusinessLayer/Manage Equipment/equipment_bloc.dart';
import '../../../Widget/CurveWidgetStaff.dart';
import '../DeliveryForm.dart';

class DisplayEquipmentDetails extends StatefulWidget {
  const DisplayEquipmentDetails({Key? key}) : super(key: key);

  @override
  State<DisplayEquipmentDetails> createState() => _DisplayEquipmentDetailsState();
}

class _DisplayEquipmentDetailsState extends State<DisplayEquipmentDetails> {
  EquipmentBloc equipmentBloc = EquipmentBloc();


  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)?.settings.arguments as Map;
    String title = todo['title'];

    return SafeArea(
        child: WillPopScope(onWillPop: () async {
          Navigator.of(context,rootNavigator: false ).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) =>
                const NavBarStaff(),
              ),
                  (Route<dynamic> route) => false);
          return true;
        }, child: Scaffold(
          appBar: AppBar(backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context,rootNavigator: false ).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                    const NavBarStaff(),
                  ),
                      (Route<dynamic> route) => false),
            ),
            elevation: 0,
          ),
          body: BlocProvider(
            create: (context) {
              equipmentBloc.add(GetSpecificEquipment(title));
              return equipmentBloc;
            },
            child: BlocBuilder<EquipmentBloc, EquipmentState>(
                builder: (context, state) {
                  if (state is EquipmentInitial) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is EquipmentLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is DisplaySpecificEquipmentQRCode) {

                    final data1 = state.specificEquipmentDetails;
                    return Container(
                      height: double.infinity,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Stack(
                            children: [
                              successfulMessage(context),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding:
                                      const EdgeInsets.symmetric(horizontal: 20),
                                      child: Card(
                                        color: const Color.fromARGB(
                                            253, 250, 250, 250),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15.0),
                                        ),
                                        elevation: 10,
                                        shadowColor: Colors.black,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 20, vertical: 5),
                                                child: Row(
                                                  children: const [
                                                    Icon(
                                                      LineIcons.info,
                                                      size: 20,
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      "Details",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(15.0),
                                                  ),
                                                  color: Colors.white,
                                                  elevation: 20,
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(
                                                        20, 0, 20, 20),
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children:  [
                                                            const Expanded(flex:1 ,child: Text("Equipment Name : ")),
                                                            Expanded(
                                                              flex:1,
                                                              child: Text(
                                                                  data1['equipmentName'],
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            )
                                                          ],
                                                        ),///name
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children:  [
                                                            const Expanded(flex:1,child: Text("Month : ")),
                                                            Expanded(
                                                              flex:1,
                                                              child: Text(
                                                                  data1['month'],
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            )
                                                          ],
                                                        ),///month
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children:  [
                                                            const Expanded(
                                                              child:  Text(
                                                                  "Date Receive : "),
                                                            ),
                                                            Expanded(
                                                              flex:1,
                                                              child: Text(
                                                                  data1['dateReceive'],
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            )
                                                          ],
                                                        ),///dateReceive
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children:  [
                                                            const Expanded(flex:1,child:  Text("Tag No : ")),
                                                            Expanded(
                                                              flex:1,
                                                              child: Text(
                                                                  data1['tagNo'],
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            )
                                                          ],
                                                        ),///tag no

                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children:  [
                                                            const  Expanded(flex:1,child: Text("Serial No : ")),
                                                            Expanded(
                                                              flex:1,
                                                              child: Text(
                                                                  data1['serialNo'],
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            )
                                                          ],
                                                        ),///serialNo
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children:  [
                                                            const Expanded(flex: 1,child: Text("Manufacturer : "),),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                  data1['manufacturer'],
                                                                  maxLines: 3,
                                                                  overflow: TextOverflow.ellipsis,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            )
                                                          ],
                                                        ),///manufacturer
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children:  [
                                                            const  Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                  "Model : "),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                  data1['model'],
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            )
                                                          ],
                                                        ),///model
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children:  [
                                                            const Expanded(flex: 1,child:  Text("Laboratory Works : ")),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                  data1['laboratoryWorks'],
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            )
                                                          ],
                                                        ),///laboratoryWorks
                                                        const SizedBox(
                                                          height: 10,
                                                        ),

                                                        Row(
                                                          children:  [
                                                            const Expanded(flex: 1,child: Text("Confirmation Date : ")),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                  data1['confirmationDate'],
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            )
                                                          ],
                                                        ),///confirmationDate
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children:  [
                                                            const Expanded(flex: 1,child: Text("Physical Condition : ")),
                                                            Expanded(
                                                              child: Text(
                                                                  data1['physicalCondition'],
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            )
                                                          ],
                                                        ),///physicalCondition
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children:  [
                                                            const Expanded(flex: 1,child:Text(
                                                                "Job No : ")),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                  data1['jobNo'],
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            )
                                                          ],
                                                        ),///jobNo
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children:  [
                                                            const Expanded(flex: 1,child: Text("status : ")),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                  data1['status'],
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            )
                                                          ],
                                                        ),/// status

                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children:  [
                                                            const Expanded(flex: 1,child:  Text("Due Date : ")),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                  data1['dueDate'],
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            )
                                                          ],
                                                        ),///dueDate
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children:  [
                                                            const Expanded(flex: 1,child: Text("Certificate Report No : ")),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                  data1['certificateReportNo'],
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            )
                                                          ],
                                                        ),///certificateReportNo
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children:  [
                                                            const Expanded(
                                                              flex: 1,
                                                              child:  Text(
                                                                  "Date Returned : "),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                  data1['dateReturned'],
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            )
                                                          ],
                                                        ),///dateReturned
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          children:  [
                                                            const Expanded(flex: 1,child: Text("Location : ")),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text(
                                                                  data1['location'],
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                      FontWeight.bold)),
                                                            )
                                                          ],
                                                        ),///location
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        checkCalibrationExpiredButton(context,data1['dueDate'] )

                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        )));
  }
}

///background color for custom widget and text message
Widget successfulMessage(context)
{
  return CurveWidgetStaff(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2,
        color: const Color.fromARGB(255, 0, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Text(
              "Thank You!!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white),
            ),
            Text(
              "Your registration is successful",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white),
            ),
          ],
        ),
      ));
}

///check if calibration if expired
Widget checkCalibrationExpiredButton(context,String  dueDateCalibration )
{
  // Define the format of the input string
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

// Parse the date string and create a DateTime object
  DateTime dateTime = dateFormat.parse(dueDateCalibration);

  // Check if the date is not the current date
  if (dateTime.isBefore(DateTime.now())) {
    ///The date is not the current date
    return SizedBox(
      width: MediaQuery.of(context)
          .size
          .height /
          2,
      // <-- Your width
      height: 50,
      // <-- Your height
      child: ElevatedButton(
        style:
        ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 0, 199, 140),
          textStyle: const TextStyle(
              fontSize: 20),
          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(
                15),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const StaffEquipmentForm()),
          );

        },
        child: const Text(
            "Calibration Expired"),
      ),
    );
  } else {
    return const Text('');
  }
}
