import 'package:bloc/bloc.dart';
import 'package:testrilapp/add_new_entry/cubit/new_gate_entry.dart';

part 'add_entry_state.dart';

class AddEntryCubit extends Cubit<AddEntryState> {
  AddEntryCubit() : super(AddEntryState(isSaved : null));
  checkRecordSaved(String driverName, String? transactionType, String? bpartnerId) async {
    bool res =  await SaveRecod().saveRecord(driverName,transactionType,bpartnerId);
    emit(AddEntryState(isSaved:  res));
  }
}
