import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testrilapp/add_new_entry/cubit/add_entry_cubit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testrilapp/add_new_entry/cubit/business_partner_cubit.dart';
import 'package:testrilapp/add_new_entry/domain/model/customerdata.dart';

class AddGateEntryScreen extends StatefulWidget {
  String? prefName;
  String? prefPass;
  AddGateEntryScreen({Key? key, this.prefName, this.prefPass})
      : super(key: key);
  @override
  _AddGateEntryScreenState createState() => _AddGateEntryScreenState();
}

class _AddGateEntryScreenState extends State<AddGateEntryScreen> {
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final _listItems = ['Raw Material', 'Spares', 'Machines'];
  String? value;
  String? myString;
  final _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Entry'),
      ),
      body: BlocListener<AddEntryCubit, AddEntryState>(
        listener: (context, state) => {
          print("STATE : ${state.isSaved}"),
          state.isSaved == true
              ? Navigator.of(context).pop(true)
              : ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 2),
                    content: Text('Can\'t able to save record',
                        textAlign: TextAlign.end),
                    backgroundColor: Colors.red,
                  ),
                )
        },
        child: Column(
          children: [
            TextFormField(
              controller: _textEditingController,
              cursorColor: Theme.of(context).cursorColor,
              maxLength: 20,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Driver Name',
                labelStyle: TextStyle(
                  color: Color(0xFF6200EE),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  elevation: 8,
                  style: const TextStyle(color: Colors.green, fontSize: 16),
                  icon: const Icon(Icons.arrow_drop_down_circle),
                  iconDisabledColor: Colors.red,
                  iconEnabledColor: Colors.green,
                  hint: const Text('Transaction Type'),
                  value: value,
                  items: _listItems.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      value = newValue!;
                    });
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () => captureImage(ImageSource.camera),
                      child: Row(children: const [
                        Text('Pick Photo'),
                        Icon(Icons.camera_alt),
                      ]),
                    )
                  ],
                ),
                Row(
                  children: [
                    if (_imageFile != null)
                      SizedBox(
                        height: 75,
                        width: 75,
                        child: Image(image: FileImage(File(_imageFile!.path))),
                      )
                    else
                      SizedBox(
                        height: 75,
                        width: 75,
                        child: Image.network(
                            'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif'),
                      ),
                  ],
                ),
              ],
            ),
            FlatButton(
                onPressed: () async {
                  _textEditingController.text.isNotEmpty
                      ? await BlocProvider.of<AddEntryCubit>(context)
                          .checkRecordSaved(
                          _textEditingController.text,
                          value,
                        )
                      : Fluttertoast.showToast(
                          msg: "Enter Driver Name",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                },
                child: const Text('Enter Record')),
          ],
        ),
      ),
    );
  }

  void captureImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile!;
    });
  }
}
