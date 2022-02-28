import 'package:bloc/bloc.dart';
import '../data/list_data_customer.dart';
import '../domain/model/customerdata.dart';

part 'business_partner_state.dart';

class BusinessPartnerCubit extends Cubit<FetchBusinessPartnerState> {
  BusinessPartnerCubit() : super(FetchBusinessPartnerState(fetchedBP: []));
  fetchBPRecords(String? prefName, String? prefPass) async {
    List<BusinessPartner> resList =  await  FetchCustomerData().fetchCustomerData(prefName!, prefPass!);
    print(resList.length);
    emit(FetchBusinessPartnerState(fetchedBP: resList));
  }
}
