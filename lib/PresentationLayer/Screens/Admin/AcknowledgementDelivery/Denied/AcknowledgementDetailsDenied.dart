import 'package:flutter/material.dart';


class AcknowledgementDetailsDenied extends StatelessWidget {
  const AcknowledgementDetailsDenied({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = ModalRoute.of(context)?.settings.arguments as Map;
    String month = todo['month'];
    String date = todo['date'];
    String designationPIC = todo['designationPIC'];
    String location = todo['location'];
    String tagNo = todo['tagNo'];
    String equipmentName = todo['equipmentName'];
    String serialNo = todo['serialNo'];
    String model = todo['model'];
    String transportationMode = todo['transportationMode'];
    String transportationFirstDescription = todo['transportationFirstDescription'];
    String physicalCondition = todo['physicalCondition'];
    String statusEquipment = todo['statusEquipment'];
    String referenceNo = todo['referenceNo'];
    String acknowledgmentReceiptName = todo['acknowledgmentReceiptName'];

    return  SafeArea(child: Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            leading: BackButton(color: Colors.black),
            floating: true,
            snap: true,
            title: Text("Delivery Details",
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
                          child:  Padding(
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
                                          "Date : "),
                                    ),
                                    Expanded(
                                      flex:1,
                                      child: Text(
                                          date,
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
                                    const Expanded(flex:1,child:  Text("PIC Name & Designation : ")),
                                    Expanded(
                                      flex:1,
                                      child: Text(
                                          designationPIC,
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
                                    const  Expanded(flex:1,child: Text("Location : ")),
                                    Expanded(
                                      flex:1,
                                      child: Text(
                                          location,
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
                                    const Expanded(flex: 1,child: Text("Transportation Mode : ")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          transportationMode,
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
                                    const Expanded(flex: 1,child: Text("Consignment Note No/ Name : ")),
                                    Expanded(
                                      child: Text(
                                          transportationFirstDescription,
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
                                        "Physical Condition : ")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          physicalCondition,
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
                                    const Expanded(flex: 1,child: Text("Status Equipment : ")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          statusEquipment,
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
                                    const Expanded(flex: 1,child: Text("Reference No : ")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          referenceNo,
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                    )
                                  ],
                                ),///referenceNo
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children:  [
                                    const Expanded(flex: 1,child:Text(
                                        "Acknowledgment Receipt Name : ")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          acknowledgmentReceiptName,
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                    )
                                  ],
                                ),///acknowledgmentReceiptName
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

