import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/BusinessLayer/Manage%20Equipment/equipment_bloc.dart';
import 'package:inventoryapp/PresentationLayer/Screens/Admin/EquipementAdmin/EquipementList.dart';

import '../../../../BusinessLayer/AuthBloc/auth_bloc.dart';
import '../../../../BusinessLayer/Manage User/user_bloc.dart';
import '../../Login.dart';
import '../AcknowledgementDelivery/AcknowledgmentDelivery.dart';
import '../AcknowledgementDelivery/Approved/AcknoledgetmentDeliveryApproved.dart';
import '../AcknowledgementDelivery/Denied/AchnowledgementDeliveryDenied.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({Key? key}) : super(key: key);

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  Color color = const Color(0x0040e0d0);

  final EquipmentBloc equipmentBloc  = EquipmentBloc();
  final UserBloc userBloc = UserBloc();

  @override
  void initState() {
    equipmentBloc.add(const GetCountBothCollection());
    super.initState();
  }

  ///refresh
  Future<void> refresh() {
    return refreshBloc().then((value) => setState(() {}));
  }
  Future<void> refreshBloc() async {
    equipmentBloc.add(const GetCountBothCollection());
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: AppBar(
        title:const Text('Dashboard AdvanceCalLab', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                tooltip: "Pull to refresh",
                icon: const Icon(Icons.info_outline_rounded),
                color: const Color.fromARGB(255, 4, 52, 84),
                onPressed: () {

                },
              );
            },
          ),
        ],
      ),
      body:MultiBlocProvider(
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
                } else if (state is CountBothCollectionLoad) {

                  return RefreshIndicator(onRefresh: refresh, child: Padding(padding: const EdgeInsets.all( 20),
                    child: ListView(
                      children: [
                        cardDelivery(state.countDelivery),
                        const SizedBox(height: 20,),
                        cardEquipment(state.countEquipment),



                      ],
                    ),));

                }  else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),

        ),
      )
      ,
    )
    );
  }

  Widget cardDelivery(countDelivery)
  {
    return  Card(
      // color: const Color.fromARGB(255, 64, 224, 208),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      shadowColor: Colors.black,
      child: Padding(padding:const EdgeInsets.all(5) ,child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Delivery",
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) =>  const AcknowledgmentDelivery()));
              //   },
              //   style: ElevatedButton.styleFrom(
              //       backgroundColor:Colors.black,
              //       maximumSize: const Size(300, 60),
              //       shape:
              //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
              //   child: const Text('Delivery List'),
              // ),
            ],
          ),
          SizedBox(
            height: 120,
            child: GridView.count(
              shrinkWrap: true,
              physics:  const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              children:  [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
                      // gradient: LinearGradient(
                      //   begin: Alignment.topRight,
                      //   end: Alignment.bottomLeft,
                      //   colors: [
                      //     Color.fromARGB(255, 64, 224, 208),
                      //     Colors.blue,
                      //   ],
                      // ),
                      color:  Color.fromRGBO(245, 241, 11, 1.0),
                    ),

                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  const AcknowledgmentDelivery()));
                      },
                      child: Card(
                          color:  Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 0,
                          shadowColor: Colors.black
                          ,child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [const Text("Pending",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))
                          , Text(countDelivery[0].toString())],
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      // gradient: LinearGradient(
                      //   begin: Alignment.topRight,
                      //   end: Alignment.bottomLeft,
                      //   colors: [
                      //     Color.fromARGB(255, 64, 224, 208),
                      //     Colors.blue,
                      //   ],
                      // ),
                      color: Color(0xFFFF2400),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  const AcknowledgmentDeliveryDenied()));
                      },
                      child: Card(
                          color:  Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 0,
                          shadowColor: Colors.black,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [const Text("Denied",
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))
                              , Text(countDelivery[2].toString())],
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                     color: Color(0xFF1E90FF),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  const AcknowledgmentDeliveryApproved()));
                      },
                      child: Card(
                          color:   Colors.transparent,
                          elevation:0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),

                          shadowColor: Colors.black,child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [const Text("Approved",
                                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))
                              , Text(countDelivery[1].toString())],
                          )),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),),
    );
  }

  Widget cardEquipment(countEquipment)
  {
    return   Card(
      // color: const Color.fromARGB(0xFF, 0x0A, 0xBA, 0xB5),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10,
      shadowColor: Colors.black,
      child: Padding(padding:const EdgeInsets.all(5) ,child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Equipment",
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  const EquipmentList()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor:Colors.black,
                    maximumSize: const Size(300, 60),
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                child: const Text('Equipment List'),
              ),
            ],
          ),
          SizedBox(
            height: 180,
            child: GridView.count(
              childAspectRatio: (2 / 1),
              crossAxisCount: 2,
              children:  [
                Padding(padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromARGB(255, 64, 224, 208),
                        Colors.blue,
                      ],
                    ),
                  ),
                  height: 20,
                  child: Card(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 0,
                    shadowColor: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Digital Multimeter",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10,),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              countEquipment[0].toString(),
                              softWrap: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  ,
                ),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromARGB(255, 64, 224, 208),
                          Colors.blue,
                        ],
                      ),
                    ),
                    height: 20,
                    child: Card(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 0,
                      shadowColor: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Digital Pressure Meter",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10,),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                countEquipment[1].toString(),
                                softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    ,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromARGB(255, 64, 224, 208),
                          Colors.blue,
                        ],
                      ),
                    ),
                    height: 20,
                    child: Card(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 0,
                      shadowColor: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Electrical Safety Analyzer",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10,),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                countEquipment[2].toString(),
                                softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    ,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromARGB(255, 64, 224, 208),
                          Colors.blue,
                        ],
                      ),
                    ),
                    height: 20,
                    child: Card(
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 0,
                      shadowColor: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Thermocouple Type K",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10,),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                countEquipment[3].toString(),
                                softWrap: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    ,
                  ),
                ),
              ],
            ),
          )
        ],
      ),),
    );
  }
}
