import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testrilapp/add_new_entry/cubit/business_partner_cubit.dart';
import 'package:testrilapp/list_view/data/transactiontype.dart';
import 'package:testrilapp/add_new_entry/presentation/add_gate_entry.dart';

import '../../add_new_entry/cubit/add_entry_cubit.dart';
import '../cubit/fetch_list_cubit.dart';

class ListViewScreen extends StatefulWidget {
  String? prefName;
  String? prefPass;
  ListViewScreen({Key? key, this.prefName, this.prefPass}) : super(key: key);
  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  @override
  void initState() {
    super.initState();
    print('Name : ${widget.prefName}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gate Entries'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BlocBuilder<FetchListCubit, FetchListState>(
            builder: (context, state) {
              return SizedBox(
                height: 650,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final myVar = state.inpGateEntryRec;
                    return SizedBox(
                      height: 50,
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 0.0, right: 0.0),
                        onTap: () => print(
                            'Record Clicked : ${myVar[index].documentNo.toString()}'),
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                          child: CircleAvatar(
                            backgroundColor: const Color(0xFFAEE1E1),
                            radius: 20,
                            child: Text(_setTransactionAvatarString(myVar[index]
                                .transactionType as TransactionType)!),
                          ),
                        ),
                        title: Container(
                          decoration: BoxDecoration(
                            border: index == 0
                                ? const Border() // This will create no border for the first item
                                : Border(
                                    top: BorderSide(
                                        width: 1,
                                        color: Theme.of(context).primaryColor),
                                  ), // This will create top borders for the rest
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(myVar[index].documentNo!,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black)),
                              Text('(${myVar[index].org})',
                                  style: const TextStyle(fontSize: 10)),
                              Text(myVar[index].driverName!,
                                  style: const TextStyle(fontSize: 10)),
                            ],
                          ),
                        ),
                        // trailing:
                        //     Text(DateFormat().add_yMd().parse(myVar[index].creationDate!).toString()),
                      ),
                    );
                  },
                  itemCount: state.inpGateEntryRec.length,
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        onPressed: () async {
          bool res = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider<AddEntryCubit>(
                create: (_) => AddEntryCubit(),
                child: BlocProvider<BusinessPartnerCubit>(
                  create: (context) => BusinessPartnerCubit(),
                  child: AddGateEntryScreen(
                      prefName: widget.prefName!, prefPass: widget.prefPass!),
                ),
              ),
            ),
          );
          if (res) {
            BlocProvider.of<FetchListCubit>(context)
                .fetchList(widget.prefName!, widget.prefPass!);
          }
        },
        child: const Icon(Icons.add, size: 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(color: Colors.black)),
      ),
    );
  }
}

String? _setTransactionAvatarString(TransactionType? type) {
  switch (type) {
    case (TransactionType.RawMaterial):
      return "RM";
    case (TransactionType.Spares):
      return "S";
    case (TransactionType.Machines):
      return "M";
    case (TransactionType.DeliveryChallan):
      return "DC";
  }
}
