import 'package:flutter/material.dart';

class EquipmentDetails extends StatelessWidget {
  const EquipmentDetails({Key? key}) : super(key: key);

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






    return  SafeArea(child: Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            leading: BackButton(color: Colors.black),
            floating: true,
            snap: true,
            title: Text("Equipment Details",
              style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          SliverList(delegate: SliverChildListDelegate([
            SingleChildScrollView(
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20),
                      child: Card(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 10,
                          shadowColor: Colors.black,
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
                                          equipmentName,
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
                                          month,
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
                                          "Date Received : "),
                                    ),
                                    Expanded(
                                      flex:1,
                                      child: Text(
                                          dateReceive,
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
                                    const Expanded(flex:1,child:  Text("Manufacturer : ")),
                                    Expanded(
                                      flex:1,
                                      child: Text(
                                          manufacturer,
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                    )
                                  ],
                                ),///Manufacturer

                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children:  [
                                    const  Expanded(flex:1,child: Text("Laboratory Works : ")),
                                    Expanded(
                                      flex:1,
                                      child: Text(
                                          laboratoryWorks,
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                    )
                                  ],
                                ),///Laboratory Works
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children:  [
                                    const Expanded(flex: 1,child: Text("Tag No : "),),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          tagNo,
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
                                          "Serial No : "),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          serialNo,
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
                                    const Expanded(flex: 1,child:  Text("Model : ")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          model,
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
                                    const Expanded(flex: 1,child: Text("Confirmation date for calibration/ Repair : ")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          confirmationDate,
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
                                    const Expanded(flex: 1,child: Text("Job No : ")),
                                    Expanded(
                                      child: Text(
                                          jobNo,
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
                                    const Expanded(flex: 1,child:Text(
                                        "Date Returned to User : ")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          dateReturned,
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                    )
                                  ],
                                ),///Date Returned to User
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children:  [
                                    const Expanded(flex: 1,child: Text("Location : ")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          location,
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                    )
                                  ],
                                ),///location
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children:  [
                                    const Expanded(flex: 1,child: Text("Physical Condition : ")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          physicalCondition,
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                    )
                                  ],
                                ),/// physicalCondition
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children:  [
                                    const Expanded(flex: 1,child: Text("Due Date of Calibration : ")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          dueDate,
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                    )
                                  ],
                                ),/// Due Date of Calibration
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children:  [
                                    const Expanded(flex: 1,child: Text("Certificate No./ Report No : ")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          certificateReportNo,
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                    )
                                  ],
                                ),/// certificateReportNo
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children:  [
                                    const Expanded(flex: 1,child: Text("Status : ")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          status,
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                    )
                                  ],
                                ),/// certificateReportNo                                ///-------------- form----------
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )
                      ))
                ],
              ),
            )]))
        ],

      ),
    ));
  }
}
