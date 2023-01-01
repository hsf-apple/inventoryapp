import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/BusinessLayer/Manage%20Equipment/equipment_bloc.dart';
import 'package:inventoryapp/PresentationLayer/Screens/Admin/EquipementAdmin/EquipementList.dart';

import '../../../../BusinessLayer/AuthBloc/auth_bloc.dart';
import '../../../../BusinessLayer/Manage User/user_bloc.dart';
import '../../Login.dart';
import '../AcknowledgementDelivery/AcknowledgmentDelivery.dart';

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


  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: AppBar(
        title:const Text('Main Page', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0,
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

                  return Padding(padding: const EdgeInsets.all( 20),
                    child: ListView(
                      children: [
                        cardDelivery(state.countDelivery),
                        const SizedBox(height: 20,),
                        cardEquipment(state.countEquipment),



                      ],
                    ),);

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
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  const AcknowledgmentDelivery()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor:Colors.black,
                    maximumSize: const Size(300, 60),
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                child: const Text('Delivery List'),
              ),
            ],
          ),
          SizedBox(
            height: 120,
            child: GridView.count(
              shrinkWrap: true,
              physics:  const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              children:  [
                Card(
                    color:  const Color.fromARGB(255, 64, 224, 208),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 10,
                    shadowColor: Colors.black
                    ,child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [const Text("Pending",
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))
                    , Text(countDelivery[0].toString())],
                )),
                Card(
                    color:  const Color.fromARGB(255, 64, 224, 208),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 10,
                    shadowColor: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [const Text("Denied",
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))
                        , Text(countDelivery[2].toString())],
                    )),
                Card(    color:  const Color.fromARGB(255, 64, 224, 208),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 10,
                    shadowColor: Colors.black,child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [const Text("Denied",
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))
                        , Text(countDelivery[1].toString())],
                    )),
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
                SizedBox(
                  height: 20,
                  child: Card(
                      color: const Color.fromARGB(0xFF, 0x0A, 0xBA, 0xB5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      shadowColor: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [const Text("Digital Multimeter",
                            textAlign: TextAlign.center, // Align the text to the center
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))
                          , const SizedBox(height: 10,),
                          Text(countEquipment[0].toString())],
                      )),
                ),
                SizedBox(
                  height: 20,
                  child: Card(  color: const Color.fromARGB(0xFF, 0x0A, 0xBA, 0xB5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      shadowColor: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [const Text("Digital Pressure Meter",
                            textAlign: TextAlign.center, // Align the text to the center
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))
                          ,const SizedBox(height: 10,),
                          Text(countEquipment[1].toString())],
                      )),
                ),
                SizedBox(
                  height: 20,
                  child: Card(  color: const Color.fromARGB(0xFF, 0x0A, 0xBA, 0xB5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      shadowColor: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [const Text("Electrical Safety Analyzer",
                            textAlign: TextAlign.center, // Align the text to the center
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))
                          ,const SizedBox(height: 10,),
                          Text(countEquipment[2].toString())],
                      )),
                ),
                SizedBox(
                  height: 20,
                  child: Card(
                      color: const Color.fromARGB(0xFF, 0x0A, 0xBA, 0xB5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 10,
                      shadowColor: Colors.black,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [const Text("Thermocouple Type K",
                            textAlign: TextAlign.center, // Align the text to the center
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))
                          ,
                          const SizedBox(height: 10,),
                          Text(countEquipment[3].toString())],
                      )),
                ),
              ],
            ),
          )
        ],
      ),),
    );
  }
}
