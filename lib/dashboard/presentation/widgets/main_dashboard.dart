import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testrilapp/dashboard/presentation/widgets/dashboard_body.dart';

import '../../../list_view/cubit/fetch_list_cubit.dart';
import '../../../login/presentation/widgets/main_log_in_page.dart';

class MainDashBoard extends StatefulWidget {
  const MainDashBoard({Key? key}) : super(key: key);

  @override
  State<MainDashBoard> createState() => _MainDashBoardState();
}

class _MainDashBoardState extends State<MainDashBoard> {
  void logOut() async {
    SharedPreferences _sharedPrefClear = await SharedPreferences.getInstance();
    await _sharedPrefClear.clear();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RILHomePage(),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DashBoard',
              style: TextStyle(fontWeight: FontWeight.bold)),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                gradient: LinearGradient(colors: [
                  Colors.blueAccent,
                  Colors.orangeAccent,
                  Colors.purple
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
          ),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: logOut, icon: const Icon(Icons.exit_to_app_sharp))
          ],
        ),
        body:  BlocProvider(create: (_) => FetchListCubit(),child: DashBoardBody()),

    );
  }
}
