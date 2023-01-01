import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/PresentationLayer/Screens/Staff/DeliveryDetails/DeliveryDetailsStaff.dart';
import 'package:inventoryapp/PresentationLayer/Screens/Login.dart';

import '../../../BusinessLayer/AuthBloc/auth_bloc.dart';
import '../../../BusinessLayer/Manage Delivery/delivery_bloc.dart';
import '../../../BusinessLayer/Manage Equipment/equipment_bloc.dart';
import '../../../DataLayer/Repository/EquipmentRepository.dart';
import 'QR code Successful Screen/DisplayEquipmentDetails.dart';

class StaffHomeScreen extends StatefulWidget {
  const StaffHomeScreen({Key? key}) : super(key: key);

  @override
  State<StaffHomeScreen> createState() => _State();
}

class _State extends State<StaffHomeScreen> {

  final EquipmentBloc equipmentBloc = EquipmentBloc();
  DeliveryBloc deliveryBloc = DeliveryBloc();
  String _scanBarcode = 'Unknown';

  Future<String> scanQR() async {
    String barcodeScanRes;

    /// Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    /// If the widget was removed from the tree while the asynchronous platform
    /// message was in flight, we want to discard the reply rather than calling
    /// setState to update our non-existent appearance.
    // if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
    return _scanBarcode;
  }



  @override
  void initState() {
    deliveryBloc.add(const GetListEquipmentDelivery());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home Page',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          // actions: [
          //   // Builder(
          //   //   builder: (BuildContext context) {
          //   //     return IconButton(
          //   //       tooltip: "Pull to refresh",
          //   //       icon: const Icon(Icons.info_outline_rounded),
          //   //       color: const Color.fromARGB(255, 4, 52, 84),
          //   //       onPressed: () {},
          //   //     );
          //   //   },
          //   // ),
          // ],
        ),

        body: Container(
          margin: const EdgeInsets.all(8.0),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<EquipmentBloc>(create: (context) => equipmentBloc),
              BlocProvider<DeliveryBloc>(create: (context) => deliveryBloc),
            ],
            child: MultiBlocListener( listeners: [
              BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) async {
                    if (state is UnAuthenticated) {
                      // Navigate to the sign in screen when the user Signs Out
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => Login()),
                            (route) => false,
                      );
                    }
                  }),
              BlocListener<EquipmentBloc, EquipmentState>(
                  listener: (context, state) async {
                    if (state is StatusResultQRCodeLoaded) {
                      ///return true if user  scan a right qr code

                      if(state.value == true)
                        {
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                              builder: (context) => const DisplayEquipmentDetails(),settings: RouteSettings(
                            arguments: {"title": _scanBarcode},
                          )));
                        }
                      else
                        {

                        }
                    }
                  })
            ],
            child: StreamBuilder<QuerySnapshot>(stream:EquipmentRepository().dataStream(),
              builder: (context, snapshot) {
              if (!snapshot.hasData) return const LinearProgressIndicator();

              ///pending
              List<DocumentSnapshot> pendingStatus = snapshot.data!.docs.where((snapshot) => snapshot['acknowledgmentStatus'] == 'Pending').toList();
              ///pending
              List<DocumentSnapshot> deniedStatus = snapshot.data!.docs.where((snapshot) => snapshot['acknowledgmentStatus'] == 'Denied').toList();
              ///pending
              List<DocumentSnapshot> approveStatus = snapshot.data!.docs.where((snapshot) => snapshot['acknowledgmentStatus'] == 'Approved').toList();

              return _uI(context, pendingStatus, deniedStatus, approveStatus,screenHeight);

            }, ),

            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 0, 199, 140),
          onPressed: () async {
           var scanBarcode =  await scanQR();
            equipmentBloc.add(GetSpecificEquipmentMainPageBool(scanBarcode));
          },
          tooltip: 'Scan QR code',
          elevation: 4.0,
          child: const Icon(Icons.qr_code),
        ),
      ),
    );
  }
}

Widget _uI(BuildContext context, pendingStatus, deniedStatus, approveStatus,screenHeight) {
  return ListView(
    children: [
      Column(
        children: <Widget>[
          SizedBox(
            // height: screenHeight * 0.20, // 20% of the screen height
            child: Card(
              child: ExpansionTile(
                onExpansionChanged: (expanded) {
                  if (expanded) {
                    // The ExpansionTile is currently expanded.
                  } else {
                    // The ExpansionTile is currently collapsed.
                  }
                },
                textColor: const Color.fromARGB(255, 24, 191, 161),
                title: const Text(
                  'Pending',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(''),
                children: <Widget>[
                  expansion(context, pendingStatus),
                ],
              ),
            ),
          ),
          // Flex(
          //   direction: Axis.horizontal,
          //   children: [
          //     Expanded(
          //       // flex: 0, // Set the flex property to 0 to maintain the fixed size of the Container
          //       child: SizedBox(
          //         // height: screenHeight * 0.20, // 20% of the screen height
          //         child: Card(
          //           child: ExpansionTile(
          //             onExpansionChanged: (expanded) {
          //               if (expanded) {
          //                 // The ExpansionTile is currently expanded.
          //               } else {
          //                 // The ExpansionTile is currently collapsed.
          //               }
          //             },
          //             textColor: const Color.fromARGB(255, 24, 191, 161),
          //             title: const Text(
          //               'Pending',
          //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          //             ),
          //             subtitle: const Text(''),
          //             children: <Widget>[
          //               expansion(context, pendingStatus),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       // flex: 1, // The second child of the Flex widget will take up the remaining space
          //       child: Container(
          //         color: Colors.green,
          //       ),
          //     ),
          //   ],
          // ),


          ///pending
          SizedBox(
            // height: screenHeight * 0.20, // 20% of the screen height
            child:Card(
              child: ExpansionTile(
                textColor: const Color.fromARGB(255, 24, 191, 161),
                title: const Text(
                  'Denied',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(''),
                children: <Widget>[
                  expansion(context, deniedStatus),
                ],
              ),
            )
          ),

          ///Approve
          SizedBox(
            // height: screenHeight * 0.20, // 20% of the screen height
            child: Card(
              child: ExpansionTile(
                textColor: const Color.fromARGB(255, 24, 191, 161),
                title: const Text(
                  'Approved',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(''),
                children: <Widget>[
                  expansion(context, approveStatus),
                ],
              ),
            ),
          ),

          ///approve
        ],
      )
    ],
  );
}



Widget expansion(BuildContext context,List<DocumentSnapshot> dataCategory) {
  return SingleChildScrollView(
    child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dataCategory.length ?? 0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const SpecificCategory(),
              //         settings: RouteSettings(
              //           arguments: {
              //             "mdc": dataCategory[index].mdc.toString(),
              //             "genericname":
              //             dataCategory[index].genericname.toString(),
              //             "prescribing":
              //             dataCategory[index].presribing.toString(),
              //             "category":
              //             dataCategory[index].category.toString(),
              //             "indication":
              //             dataCategory[index].indication.toString(),
              //             "dosage":
              //             dataCategory[index].dosage.toString(),
              //             "drugId":
              //             dataCategory[index].drugId.toString(),
              //           },
              //         )));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DeliveryDetailsStaff(),
                      settings: RouteSettings(
                        arguments: {
                          "month": dataCategory[index].get("month"),
                          "date": dataCategory[index].get("date"),
                          "designationPIC": dataCategory[index].get("designationPIC"),
                          "location": dataCategory[index].get("location"),
                          "tagNo": dataCategory[index].get("tagNo"),
                          "equipmentName": dataCategory[index].get("equipmentName"),
                          "serialNo": dataCategory[index].get("serialNo"),
                          "model": dataCategory[index].get("model"),
                          "transportationMode": dataCategory[index].get("transportationMode"),
                          "transportationFirstDescription": dataCategory[index].get("transportationFirstDescription"),
                          "physicalCondition": dataCategory[index].get("physicalCondition"),
                          "statusEquipment": dataCategory[index].get("statusEquipment"),
                          "referenceNo": dataCategory[index].get("referenceNo"),
                          "acknowledgmentStatus": dataCategory[index].get("acknowledgmentStatus"),
                          "acknowledgmentReceipt": dataCategory[index].get("acknowledgmentReceipt"),
                          "acknowledgmentReceiptName":dataCategory[index].get("acknowledgmentReceiptName"),
                          "acknowledgmentReceiptDate":dataCategory[index].get("acknowledgmentReceiptDate"),
                          "userEmail": dataCategory[index].get("userEmail"),
                        },
                      )));
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Text(
                                dataCategory[index].get('equipmentName'),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Text(dataCategory[index].get('serialNo'),),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
  );
}

