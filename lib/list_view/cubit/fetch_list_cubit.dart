import 'package:bloc/bloc.dart';
import 'package:testrilapp/dashboard/data/list_data_gateentry.dart';
import 'package:testrilapp/dashboard/domain/gateentry.dart';
part 'fetch_list_state.dart';

class FetchListCubit extends Cubit<FetchListState> {
  FetchListCubit() : super(FetchListState(inpGateEntryRec: [],isLoaded: false));
  fetchList(String prefName, String prefPass) async {
    emit(FetchListState(isLoaded: false,inpGateEntryRec: []));
    List<GateEntry> list =await  FetchedGateEntryData().fetchedGateEntryData(prefName, prefPass);
    emit(FetchListState(inpGateEntryRec: list));
  }
}
