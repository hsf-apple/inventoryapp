import 'package:flutter/material.dart';

import '../../../Service/pdf.dart';

class DeliveryDetailsStaff extends StatefulWidget {
  const DeliveryDetailsStaff({Key? key}) : super(key: key);

  @override
  State<DeliveryDetailsStaff> createState() => _DeliveryDetailsStaffState();
}

class _DeliveryDetailsStaffState extends State<DeliveryDetailsStaff> {
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
    // String acknowledgmentStatus = todo['acknowledgmentStatus'];
    String acknowledgmentReceipt = todo['acknowledgmentReceipt'];
    String acknowledgmentReceiptName = todo['acknowledgmentReceiptName'];
    String acknowledgmentReceiptDate = todo['acknowledgmentReceiptDate'];
    // String userEmail = todo['userEmail'];

    return  SafeArea(child: Scaffold(
      body: CustomScrollView(
        slivers: [
           SliverAppBar(
            leading: const BackButton(color: Colors.black),
            floating: true,
            snap: true,
            title:const Text("Delivery Details",
              style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.print,color: Colors.black),
                onPressed: () async {
              final pdfFile = await PdfApi
                  .generateCenteredText(
                  month,
                  date,
                  transportationMode,
                  designationPIC,
                  location,
                  equipmentName,
                  tagNo,
                  serialNo,
                  model,
                  physicalCondition,
                  statusEquipment,
                  referenceNo,
                  acknowledgmentReceipt,
                  acknowledgmentReceiptName,
                  acknowledgmentReceiptDate);

              PdfApi.openFile(pdfFile);
              setState(() {  PdfApi.openFile(pdfFile); });
              },
              ),

            ],
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
                                Row(
                                  children:  [
                                    const Expanded(flex: 1,child:Text(
                                        "Reference No : ")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          referenceNo,
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                    )
                                  ],
                                ),///reference No
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children:  [
                                    const Expanded(flex: 1,child:Text(
                                        "Acknowledgement Receipt from Admin : ")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          acknowledgmentReceipt,
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                    )
                                  ],
                                ),///acknowledgement receipt
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children:  [
                                    const Expanded(flex: 1,child:Text(
                                        "Admin Name (Acknowledgement Receipt) : ")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          acknowledgmentReceiptName,
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                    )
                                  ],
                                ),///acknowledgement receipt name
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children:  [
                                    const Expanded(flex: 1,child:Text(
                                        "Date (Acknowledgement Receipt)  : ")),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                          acknowledgmentReceiptDate,
                                          style: const TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                    )
                                  ],
                                ),///reference No

                                const SizedBox(
                                  height: 10,
                                )
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
