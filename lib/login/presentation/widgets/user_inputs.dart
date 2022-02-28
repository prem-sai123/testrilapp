import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testrilapp/dashboard/presentation/widgets/main_dashboard.dart';
import 'package:testrilapp/login/presentation/cubit/login_cubit.dart';

import '../../../list_view/cubit/fetch_list_cubit.dart';

class UserInputs extends StatefulWidget {
  const UserInputs({Key? key}) : super(key: key);
  @override
  State<UserInputs> createState() => _UserInputsState();
}

class _UserInputsState extends State<UserInputs> {
  String? hintText;
  final TextEditingController? _uNameController =
      TextEditingController(text: 'Janya');
  final TextEditingController? _psWDController =
      TextEditingController(text: 'rahul');
  bool _showPassword = false;
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? val = preferences.getString('isLoggedIn');
    print("LOGIN : $val");
    if (val != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
              create: (context) => FetchListCubit(),
              child: const MainDashBoard()),
        ),
      );
    }
  }

  void checkPasswordDisplay() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginCubitState>(
      listener: (context, state) async {
        if (state.loginSuccess == true) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setString("username", _uNameController!.text);
          await preferences.setString("password", _psWDController!.text);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(create: (context) => FetchListCubit(),child: const MainDashBoard()),
            ),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade50))),
              child: Column(
                children: [
                  TextField(
                    controller: _uNameController,
                    decoration: textDec('username'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: !_showPassword,
                    controller: _psWDController,
                    decoration: textDec('password'),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 35),
            child: FloatingActionButton.extended(
              tooltip: 'Hello',
              onPressed: () async {
                await BlocProvider.of<LoginCubit>(context).checkUserExists(
                    _uNameController!.text, _psWDController!.text);
              },
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              label: const Text('LOGIN'),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration textDec(String text) {
    return InputDecoration(
        prefixIcon: const Icon(Icons.edit),
        hintText: text,
        hintStyle: const TextStyle(
          color: Colors.black87,
          fontStyle: FontStyle.italic,
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple, width: 1.0),
        ),
        suffix: text == 'password'
            ? InkWell(
                child: _showPassword ? const Text('Hide') : const Text('Show'),
                onTap: () {
                  checkPasswordDisplay();
                },
              )
            : null);
  }
}
