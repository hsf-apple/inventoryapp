import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventoryapp/PresentationLayer/Screens/Admin/BottomNavBar/NavBarAdmin.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../BusinessLayer/Manage Equipment/equipment_bloc.dart';
import '../../../../DataLayer/Model/DeliveryModel.dart';
import '../../../Service/Notification.dart';
import 'AcknowledgmentDelivery.dart';

class AcknowledgementDetails extends StatefulWidget {
  const AcknowledgementDetails({Key? key}) : super(key: key);

  @override
  State<AcknowledgementDetails> createState() => _AcknowledgementDetailsState();
}

class _AcknowledgementDetailsState extends State<AcknowledgementDetails> {
  final _formKey = GlobalKey<FormState>();
  String acknowledgmentReceipt = "Received with accessories as above";


  final TextEditingController _referenceNo = TextEditingController();

  ///controller for Acknowledge Receipt from Admin (Name)
  final TextEditingController _acknowledgeReceiptName = TextEditingController();
  final EquipmentBloc equipmentBloc = EquipmentBloc();

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
    // String referenceNo = todo['referenceNo'];
    // String acknowledgmentStatus = todo['acknowledgmentStatus'];
    // String acknowledgmentReceipt = todo['acknowledgmentReceipt'];
    // String userEmail = todo['userEmail'];




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
                      child: Form(
                        key: _formKey,
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

                              ///-------------- form----------
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children:  [
                                  referenceNoField()
                                ],
                              ),///reference No
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children:  [
                                  acknowledgementReceiptAdminField()
                                ],
                              ),///acknowledgement receipt
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children:  [
                                  acknowledgementReceiptField()
                                ],
                              ),///acknowledgement receipt name
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(child:  ElevatedButton(
                                    onPressed: () async{
                                      if(_formKey.currentState!.validate()){

                                        _formKey.currentState!.save();

                                        DateTime returnDateInitial = DateTime.now();

                                        String returnDateString = DateFormat('dd/MM/yyyy').format(returnDateInitial);


                                        DeliveryModel deliveryModel = DeliveryModel(
                                            serialNo: serialNo,
                                            referenceNo: _referenceNo.text,
                                            acknowledgmentStatus: "Denied",
                                            acknowledgmentReceipt: acknowledgmentReceipt,
                                            acknowledgmentReceiptName:_acknowledgeReceiptName.text,
                                            acknowledgmentReceiptDate:returnDateString

                                        );

                                        equipmentBloc.add(UpdateDelivery(deliveryModel));


                                        sendQueryReminderNotification(deliveryModel);

                                        Navigator.of(context,rootNavigator: false ).pushAndRemoveUntil(
                                            MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                              const AcknowledgmentDelivery(),
                                            ),
                                                (Route<dynamic> route) => false);

                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        elevation: 0,
                                        maximumSize: const Size(300, 60),
                                        shape:
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)
                                            ,side: const BorderSide(color: Colors.black, width: 1),)),
                                    child: const Text('Denied', style: TextStyle(color: Colors.black)),
                                  )),
                                  const SizedBox(width: 8),
                                 Expanded(child:  ElevatedButton(
                                   onPressed: () async{
                                     if(_formKey.currentState!.validate()){

                                       _formKey.currentState!.save();

                                       DateTime returnDateInitial = DateTime.now();

                                       String returnDateString = DateFormat('dd/MM/yyyy').format(returnDateInitial);


                                       DeliveryModel deliveryModel = DeliveryModel(
                                           serialNo: serialNo,
                                           referenceNo: _referenceNo.text,
                                           acknowledgmentStatus: "Approved",
                                           acknowledgmentReceipt: acknowledgmentReceipt,
                                           acknowledgmentReceiptName:_acknowledgeReceiptName.text,
                                           acknowledgmentReceiptDate:returnDateString

                                       );

                                       equipmentBloc.add(UpdateDelivery(deliveryModel));


                                       sendQueryReminderNotification(deliveryModel);

                                       Navigator.of(context,rootNavigator: false ).pushAndRemoveUntil(
                                           MaterialPageRoute(
                                             builder: (BuildContext context) =>
                                             const AcknowledgmentDelivery(),
                                           ),
                                               (Route<dynamic> route) => false);

                                     }
                                   },
                                   style: ElevatedButton.styleFrom(
                                       backgroundColor:const Color.fromARGB(255, 0, 199, 140),
                                       maximumSize: const Size(300, 60),
                                       shape:
                                       RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                                   child: const Text('Approved'),
                                 ))
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
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

  Widget acknowledgementReceiptAdminField(){

    return Expanded(
    
        child: DropdownButtonFormField(
            isExpanded: true,
            validator: (value) {
              if (value == null) {
                return 'Please enter valid acknowledge receipt';
              }
              return null;
            },
            decoration: const InputDecoration(
              label: Text('Acknowledge Receipt '),
            ),
            value: acknowledgmentReceipt,
            elevation: 16,
            items: <String>['Received with accessories as above', 'Received without accessories as above', 'Received in Good Position']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue){
              setState(() {
                acknowledgmentReceipt = newValue!;
              });
            }
        ),
      
    );
  }

  Widget referenceNoField(){
    return Expanded(child: TextFormField(
      controller: _referenceNo,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Reference No'),
      ),
    ));
  }

  Widget acknowledgementReceiptField(){
    return Expanded(child: TextFormField(
      controller: _acknowledgeReceiptName,
      validator: (value){
        if (value == null || value.isEmpty) {
          return 'Please enter the field';
        }
        return null;
      },
      decoration: const InputDecoration(
        label: Text('Name'),
      ),
    ));
  }
}


