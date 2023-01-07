import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../BusinessLayer/AuthBloc/auth_bloc.dart';
import '../../../../BusinessLayer/Manage Equipment/equipment_bloc.dart';
import '../../../../BusinessLayer/Manage User/user_bloc.dart';
import '../../../../DataLayer/Model/EquipmentAdminModel.dart';
import '../../Login.dart';
import 'EquipmentListDetails.dart';

class EquipmentListUser extends StatefulWidget {
  const EquipmentListUser({Key? key}) : super(key: key);

  @override
  State<EquipmentListUser> createState() => _EquipmentListUserState();
}

class _EquipmentListUserState extends State<EquipmentListUser> {

  final EquipmentBloc equipmentBloc = EquipmentBloc();
  final UserBloc userBloc = UserBloc();

  @override
  void initState() {
    equipmentBloc.add(const GetListEquipmentAdmin());
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Equipment List',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),

        body: Container(
          margin: const EdgeInsets.all(8.0),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<EquipmentBloc>(create: (context) => equipmentBloc),
            ],
            child: MultiBlocListener( listeners: [
              BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) async {
                    if (state is UnAuthenticated) {
                      // Navigate to the sign in screen when the user Signs Out
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const Login()),
                            (route) => false,
                      );
                    }
                  }),
            ],
              child:  BlocBuilder<EquipmentBloc, EquipmentState>(
                  builder: (context, state) {
                    if (state is EquipmentInitial) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is EquipmentLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ListEquipmentLoadAdmin) {

                      if(state.equipmentModel.isEmpty)
                      {
                        return Container();
                      }
                      else
                      {
                        ///pending
                        List<EquipmentAdminModel> nameDigitalMultimeter = state.equipmentModel.where((snapshot) => snapshot.equipmentName == 'Digital Multimeter').toList();
                        ///pending
                        List<EquipmentAdminModel> nameDigitalPressure = state.equipmentModel.where((snapshot) => snapshot.equipmentName == 'Digital Pressure Meter').toList();
                        ///pending
                        List<EquipmentAdminModel> nameElectrical = state.equipmentModel.where((snapshot) => snapshot.equipmentName == 'Electrical Safety Analyzer').toList();

                        ///pending
                        List<EquipmentAdminModel> nameThermocouple = state.equipmentModel.where((snapshot) => snapshot.equipmentName == 'Thermocouple Type K').toList();

                        return _uI(context, nameDigitalMultimeter, nameDigitalPressure, nameElectrical,nameThermocouple,screenHeight);
                      }


                    }  else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),

            ),
          ),
        ),

      ),
    );
  }

  Widget _uI(BuildContext context, nameDigitalMultimeter, nameDigitalPressure, nameElectrical,nameThermocouple,screenHeight) {
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
                  title:  Row(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset('assets/DigitalMultimeter.png'),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Digital Multimeter',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: const Text(''),
                  children: <Widget>[
                    expansion(context, nameDigitalMultimeter),
                  ],
                ),
              ),
            ),
            ///name Digital Multimeter
            SizedBox(
              // height: screenHeight * 0.20, // 20% of the screen height
                child:Card(
                  child: ExpansionTile(
                    textColor: const Color.fromARGB(255, 24, 191, 161),
                    title:  Row(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Image.asset('assets/ElectricalSafetyAnalyzer.png'),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Electrical Safety Analyzer',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    subtitle: const Text(''),
                    children: <Widget>[
                      expansion(context, nameElectrical),
                    ],
                  ),
                )
            ),
            ///Electrical Safety Analyzer
            SizedBox(
              // height: screenHeight * 0.20, // 20% of the screen height
              child: Card(
                child: ExpansionTile(
                  textColor: const Color.fromARGB(255, 24, 191, 161),
                  title:Row(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset('assets/DigitalPressureMeter.png'),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Digital Pressure Meter',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: const Text(''),
                  children: <Widget>[
                    expansion(context, nameDigitalPressure),
                  ],
                ),
              ),
            ),
            ///Digital Pressure Meter
            SizedBox(
              // height: screenHeight * 0.20, // 20% of the screen height
              child: Card(
                child: ExpansionTile(
                  textColor: const Color.fromARGB(255, 24, 191, 161),
                  title:Row(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset('assets/K.png'),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Thermocouple Type K',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: const Text(''),
                  children: <Widget>[
                    expansion(context, nameThermocouple),
                  ],
                ),
              ),
            ),
            ///Thermocouple Type K
          ],
        )
      ],
    );
  }



  Widget expansion(BuildContext context,List<EquipmentAdminModel> dataCategory) {
    return SingleChildScrollView(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: dataCategory.length ?? 0,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {

                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const EquipmentListDetails(),
                        settings: RouteSettings(
                          arguments: {
                            "month": dataCategory[index]
                                .month
                                .toString(),
                            "dateReceive": dataCategory[index]
                                .dateReceive
                                .toString(),
                            "equipmentName": dataCategory[index]
                                .equipmentName
                                .toString(),
                            "tagNo": dataCategory[index]
                                .tagNo
                                .toString(),
                            "serialNo": dataCategory[index]
                                .serialNo
                                .toString(),
                            "manufacturer": dataCategory[index]
                                .manufacturer
                                .toString(),
                            "model": dataCategory[index]
                                .model
                                .toString(),
                            "laboratoryWorks": dataCategory[index]
                                .laboratoryWorks
                                .toString(),
                            "confirmationDate": dataCategory[index]
                                .confirmationDate
                                .toString(),
                            "physicalCondition": dataCategory[index]
                                .physicalCondition
                                .toString(),
                            "jobNo": dataCategory[index]
                                .jobNo
                                .toString(),
                            "status": dataCategory[index]
                                .status
                                .toString(),
                            "dueDate": dataCategory[index]
                                .dueDate
                                .toString(),
                            "certificateReportNo": dataCategory[index]
                                .certificateReportNo
                                .toString(),
                            "dateReturned": dataCategory[index]
                                .dateReturned
                                .toString(),
                            "location": dataCategory[index]
                                .location
                                .toString(),

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
                                  dataCategory[index].equipmentName!,
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8),
                                child: Text(dataCategory[index].serialNo!),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

