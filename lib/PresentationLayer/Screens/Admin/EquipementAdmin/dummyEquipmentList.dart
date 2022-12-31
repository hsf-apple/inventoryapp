import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/BusinessLayer/Manage%20Equipment/equipment_bloc.dart';

import '../../../../BusinessLayer/Manage User/user_bloc.dart';
import 'EquipementAdd.dart';
import 'EquipementUpdate.dart';

class EquipmentList extends StatefulWidget {
  const EquipmentList({Key? key}) : super(key: key);

  @override
  State<EquipmentList> createState() => _EquipmentListState();
}

class _EquipmentListState extends State<EquipmentList> {

  final EquipmentBloc equipmentBloc = EquipmentBloc();
  final UserBloc userBloc = UserBloc();

  @override
  void initState() {
    equipmentBloc.add(const GetListEquipmentAdmin());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Equipment List'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          actions: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EquipmentAdd()));
                  },
                );
              },
            ),
          ],
        ),
        body: Container(
          margin: const EdgeInsets.all(8),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                lazy: false,
                create: (context) {
                  return equipmentBloc;
                },
              ),
              // BlocProvider(create: (context) => userBloc..add((GetUserDetails()))),
            ],
            child: BlocBuilder<EquipmentBloc, EquipmentState>(
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
                      return ListView.builder(
                          itemCount: state.equipmentModel.isEmpty
                              ? 0
                              : state.equipmentModel.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {},
                                child: Card(
                                  elevation: 5,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: Text(
                                                  state.equipmentModel[index].equipmentName
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, right: 8),
                                                child: Text(state.equipmentModel[index].serialNo.toString()
                                                  ,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.normal),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  icon: const Icon(Icons.edit),
                                                  onPressed: () async {
                                                    await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                            const EquipmentUpdate(),
                                                            settings: RouteSettings(
                                                              arguments: {
                                                                "month": state.equipmentModel[
                                                                index]
                                                                    .month
                                                                    .toString(),
                                                                "dateReceive": state.equipmentModel[
                                                                index]
                                                                    .dateReceive
                                                                    .toString(),
                                                                "equipmentName": state.equipmentModel[
                                                                index]
                                                                    .equipmentName
                                                                    .toString(),
                                                                "tagNo": state.equipmentModel[
                                                                index]
                                                                    .tagNo
                                                                    .toString(),
                                                                "serialNo": state.equipmentModel[
                                                                index]
                                                                    .serialNo
                                                                    .toString(),
                                                                "manufacturer": state.equipmentModel[
                                                                index]
                                                                    .manufacturer
                                                                    .toString(),
                                                                "model": state.equipmentModel[
                                                                index]
                                                                    .model
                                                                    .toString(),
                                                                "laboratoryWorks": state.equipmentModel[
                                                                index]
                                                                    .laboratoryWorks
                                                                    .toString(),
                                                                "confirmationDate": state.equipmentModel[
                                                                index]
                                                                    .confirmationDate
                                                                    .toString(),
                                                                "physicalCondition": state.equipmentModel[
                                                                index]
                                                                    .physicalCondition
                                                                    .toString(),
                                                                "jobNo": state.equipmentModel[
                                                                index]
                                                                    .jobNo
                                                                    .toString(),
                                                                "status": state.equipmentModel[
                                                                index]
                                                                    .status
                                                                    .toString(),
                                                                "dueDate": state.equipmentModel[
                                                                index]
                                                                    .dueDate
                                                                    .toString(),
                                                                "certificateReportNo": state.equipmentModel[
                                                                index]
                                                                    .certificateReportNo
                                                                    .toString(),
                                                                "dateReturned": state.equipmentModel[
                                                                index]
                                                                    .dateReturned
                                                                    .toString(),
                                                                "location": state.equipmentModel[
                                                                index]
                                                                    .location
                                                                    .toString(),

                                                              },
                                                            )));
                                                  },
                                                ), //update
                                                IconButton(
                                                  icon: const Icon(Icons.delete),
                                                  onPressed: () {
                                                    setState(() {
                                                      (context).read<EquipmentBloc>()
                                                          .add(DeleteEquipmentAdmin(
                                                          state.equipmentModel[index].serialNo!)); });

                                                  },
                                                ),

                                              ],
                                            ),
                                          ],
                                        )//icon
                                      ],
                                    ),
                                  ),
                                ));
                          });
                    }


                  }  else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ),
      ),
    );
  }
}
