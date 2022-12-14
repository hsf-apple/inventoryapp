import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/PresentationLayer/Screens/Login.dart';

import '../../../BusinessLayer/AuthBloc/auth_bloc.dart';
import '../../../BusinessLayer/Manage Delivery/delivery_bloc.dart';
import '../../../BusinessLayer/Manage Equipment/equipment_bloc.dart';
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
      print(barcodeScanRes);
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
          actions: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  tooltip: "Pull to refresh",
                  icon: const Icon(Icons.info_outline_rounded),
                  color: const Color.fromARGB(255, 4, 52, 84),
                  onPressed: () {},
                );
              },
            ),
          ],
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
                      print("check if true or not for bloc listener");
                      if(state.value == true)
                        {
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                              builder: (context) => const DisplayEquipmentDetails(),settings: RouteSettings(
                            arguments: {"title": _scanBarcode},
                          )));
                        }
                    }
                  })
            ]
               , child:BlocBuilder<DeliveryBloc, DeliveryState>(
                builder: (context, state) {
                   if (state is ListEquipmentUserLoadDelivery) {
                    //select based on category
                    var pendingStatus = state.equipmentModel
                        .where((element) => element.acknowledgmentStatus == 'Pending')
                        .toList();
                    var deniedStatus = state.equipmentModel
                        .where((element) => element.acknowledgmentStatus == 'Denied')
                        .toList();
                    var approveStatus = state.equipmentModel
                        .where((element) => element.acknowledgmentStatus == 'Approve')
                        .toList();

                    return _uI(context, pendingStatus, deniedStatus, approveStatus,screenHeight);
                  } else if (state is EquipmentError) {
                     print('error');
                    return Container();
                  } else {
                     print('null');
                    return  Container();
                  }
                }) ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 33, 150, 243),
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
            height: screenHeight * 0.20, // 20% of the screen height
            child: Card(
              child: ExpansionTile(
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

          ///pending
          SizedBox(
            height: screenHeight * 0.20, // 20% of the screen height
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

          ///denied
          SizedBox(
            height: screenHeight * 0.20, // 20% of the screen height
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

Widget expansion(BuildContext context, dataCategory) {
  return SingleChildScrollView(
    child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: dataCategory == null ? 0 : dataCategory.length,
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
                                dataCategory[index].equipmentName,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Text(dataCategory[index].serialNo),
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
