import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testrilapp/login/presentation/cubit/login_cubit.dart';
import 'package:testrilapp/login/presentation/widgets/footer.dart';
import 'package:testrilapp/login/presentation/widgets/header.dart';
import 'package:testrilapp/login/presentation/widgets/user_inputs.dart';

class RILHomePage extends StatefulWidget {
  const RILHomePage({Key? key}) : super(key: key);
  @override
  _RILHomePageState createState() => _RILHomePageState();
}

class _RILHomePageState extends State<RILHomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('RIL Test Login'),
          elevation: 6,
          toolbarHeight: 50,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: 500,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [
                  0.1,
                  0.5,
                  0.8,
                  0.9
                ],
                    colors: [
                  Colors.red,
                  Colors.yellow,
                  Colors.blue,
                  Colors.purple
                ])),
            child: Column(
              children: [
                const Header(),
                Container(
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(60),
                    ),
                  ),
                  child: BlocProvider(
                      create: (_) => LoginCubit(), child: const UserInputs()),
                ),
                const Expanded(child:  Footer())
              ],
            ),
          ),
        ),
      );
  }
}
