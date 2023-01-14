import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:inventoryapp/BusinessLayer/Manage%20Delivery/delivery_bloc.dart';
import 'package:inventoryapp/PresentationLayer/Screens/Admin/AcknowledgementDelivery/Denied/AcknowledgementDetailsDenied.dart';
import 'dart:collection';

import '../../../../../DataLayer/Model/DeliveryModel.dart';
import 'AcknoledgmentDetailsApproved.dart';


class AcknowledgmentDeliveryApproved extends StatefulWidget{
  const AcknowledgmentDeliveryApproved({super.key});

  @override
  State<StatefulWidget> createState() => _AcknowledgmentDeliveryApproved();

}

class _AcknowledgmentDeliveryApproved extends State<AcknowledgmentDeliveryApproved>{

  DeliveryBloc deliveryBloc = DeliveryBloc();

  @override
  void initState() {
    deliveryBloc.add(const GetListEquipmentDeliveryAdminApproved());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("List Approved Delivery",
            style: TextStyle(color: Colors.black),),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: BlocProvider(create:(_) => deliveryBloc, child: BlocBuilder<DeliveryBloc, DeliveryState>(
            builder: (context, state) {
              if (state is DeliveryInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is DeliveryLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ListEquipmentDeliveryAdminLoad) {
                final dateFormat = new DateFormat("dd/MM/yyyy");
                final currentYear = DateTime.now().year;
                Map<int, List<DeliveryModel>> resultsByMonth = {};
                state.equipmentModel.where((result) => dateFormat.parse(result.acknowledgmentReceiptDate!).year == currentYear).forEach((result) {
                  final month = dateFormat.parse(result.acknowledgmentReceiptDate!).month;
                  if(!resultsByMonth.containsKey(month)){
                    resultsByMonth[month] = [result];
                  } else {
                    resultsByMonth[month]?.add(result);
                  }
                });

                return ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  children: [
                     _UI(context,resultsByMonth[1], 'January'),
                    _UI(context,resultsByMonth[2], 'February'),
                    _UI(context,resultsByMonth[3], 'March'),
                    _UI(context,resultsByMonth[4], 'April'),
                    _UI(context,resultsByMonth[5], 'May'),
                    _UI(context,resultsByMonth[6], 'June'),
                    _UI(context,resultsByMonth[7], 'July'),
                    _UI(context,resultsByMonth[8], 'August'),
                    _UI(context,resultsByMonth[9], 'September'),
                    _UI(context,resultsByMonth[10], 'October'),
                    _UI(context,resultsByMonth[11], 'November'),
                    _UI(context,resultsByMonth[12], 'December'),
                  ],
                );


                // return _UI(context,resultsByMonth);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),),
      ),
    );
  }
  Widget _UI(BuildContext context, state,String monthName) {
    return Card(
   child: Column(
     children: [
       Row(
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
           Padding(padding: EdgeInsets.all(8),child:  Text( monthName,
               style: TextStyle(
                   fontSize: 17,
                   fontWeight: FontWeight.bold)),),
         ],
       ),
       ListView.builder(
           shrinkWrap: true,
           itemCount: state == null ? 0 : state.length,
           itemBuilder: (context, index) {
             return GestureDetector(
               onTap: () {

                 Navigator.push(
                     context,
                     MaterialPageRoute(
                         builder: (context) => const AcknowledgementDetailsApproved(),
                         settings: RouteSettings(
                           arguments: {
                             "month": state[index].month.toString(),
                             "date": state[index].date.toString(),
                             "designationPIC": state[index].designationPIC.toString(),
                             "location": state[index].location.toString(),
                             "tagNo": state[index].tagNo.toString(),
                             "equipmentName": state[index].equipmentName.toString(),
                             "serialNo": state[index].serialNo.toString(),
                             "model": state[index].model.toString(),
                             "transportationMode": state[index].transportationMode.toString(),
                             "transportationFirstDescription": state[index].transportationFirstDescription.toString(),
                             "physicalCondition": state[index].physicalCondition.toString(),
                             "statusEquipment": state[index].statusEquipment.toString(),
                             "referenceNo": state[index].referenceNo.toString(),
                             "acknowledgmentStatus": state[index].acknowledgmentStatus.toString(),
                             "acknowledgmentReceipt": state[index].acknowledgmentReceipt.toString(),
                             "userEmail": state[index].date.toString(),
                             "acknowledgmentReceiptName":state[index].acknowledgmentReceiptName.toString(),
                           },
                         ))).then((value) => setState(() {
                   deliveryBloc.add(const GetListEquipmentDeliveryAdminApproved());
                 }));

               },
               child: Card(
                 elevation: 5,
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
                                   state[index].equipmentName.toString(),
                                   style: const TextStyle(
                                       fontSize: 16, fontWeight: FontWeight.bold),
                                 ),
                               ),
                               Padding(
                                 padding: const EdgeInsets.only(left: 8, right: 8),
                                 child: Text(state[index].serialNo.toString()),
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
           })
     ],
   ),
    );
  }



}

