import 'package:flutter/material.dart';
import 'package:inventoryapp/BusinessLayer/Manage%20Equipment/equipment_bloc.dart';

import '../../../../BusinessLayer/Manage User/user_bloc.dart';

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
      body:Padding(padding: const EdgeInsets.all( 20),
        child: ListView(
          children: [
            Card(
              color: const Color.fromARGB(0xFF, 0x0A, 0xBA, 0xB5),
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor:Colors.black,
                            maximumSize: const Size(300, 60),
                            shape:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                        child: const Text('Equipment List'),
                      ),
                    ],
                  ),
                  Container(
                    height: 360,
                    child: GridView.count(
                      crossAxisCount: 2,
                      children:  [
                        Card(
                            color: const Color.fromARGB(255, 64, 224, 208),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 10,
                            shadowColor: Colors.black,
                            child: Text('Card 1')),
                        Card(  color: const Color.fromARGB(255, 64, 224, 208),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 10,
                            shadowColor: Colors.black,
                            child: Text('Card 2')),
                        Card(  color: const Color.fromARGB(255, 64, 224, 208),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 10,
                            shadowColor: Colors.black,
                            child: Text('Card 3')),
                        Card(
                            color: const Color.fromARGB(255, 64, 224, 208),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 10,
                            shadowColor: Colors.black,
                            child: Text('Card 4')),
                      ],
                    ),
                  )
                ],
              ),),
            ),
            Card(
              color: const Color.fromARGB(255, 64, 224, 208),
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
                        onPressed: () {},
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
                      crossAxisCount: 3,
                      children:  [
                        Card(
                            color: const Color.fromARGB(0xFF, 0x0A, 0xBA, 0xB5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 10,
                            shadowColor: Colors.black
                            ,child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Text('Card 1'),Text('Card 1')],
                        )),
                        Card(
                            color: const Color.fromARGB(0xFF, 0x0A, 0xBA, 0xB5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 10,
                            shadowColor: Colors.black,
                            child: Text('Card 2')),
                        Card(    color: const Color.fromARGB(0xFF, 0x0A, 0xBA, 0xB5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 10,
                            shadowColor: Colors.black,child: Text('Card 3')),
                      ],
                    ),
                  )
                ],
              ),),
            ),

          ],
        ),)
      ,
    )
    );
  }
}
