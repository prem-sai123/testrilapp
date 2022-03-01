import 'package:bloc/bloc.dart';
import '../../data/check_user_exists.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  LoginCubit() : super(LoginCubitState(loginSuccess: false, isLoading: false));
  checkUserExists(String userName, String passWord) async {
    emit(LoginCubitState(isLoading: true));
    bool res =  await UserExists().fetchADUserData(userName, passWord);
    print(res);
    emit(LoginCubitState(loginSuccess: res,isLoading: false));
  }
}
