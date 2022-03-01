import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../list_view/cubit/fetch_list_cubit.dart';
import '../../../list_view/presentation/listview_screen.dart';

class DashBoardBody extends StatefulWidget {
  @override
  _DashBoardBodyState createState() => _DashBoardBodyState();
}

class _DashBoardBodyState extends State<DashBoardBody> {
  String? _prefName;
  String? _prefPass;
  @override
  initState() {
    super.initState();
    getPrefName();
  }

  getPrefName() async {
    SharedPreferences _sharedPrefName = await SharedPreferences.getInstance();
    setState(() {
      _prefName = _sharedPrefName.getString('username');
      _prefPass = _sharedPrefName.getString('password');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocListener<FetchListCubit, FetchListState>(
          listener: (context, state) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<FetchListCubit>(context),
                    child: ListViewScreen(
                      prefName: _prefName,
                      prefPass: _prefPass,
                    )),
              ),
            );
          },
          child: Column(
            children: [
              SizedBox(
                height: 75,
                width: 100,
                child: GestureDetector(
                  onTap: () async {
                    BlocProvider.of<FetchListCubit>(context)
                        .fetchList(_prefName!, _prefPass!);
                  },
                  child: Card(
                    elevation: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 50,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_circle_up_sharp,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                            const Text('Gate Entry'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.orangeAccent,
                  child: Text(
                    'Welcome $_prefName',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
