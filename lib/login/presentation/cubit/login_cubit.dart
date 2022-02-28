import 'package:bloc/bloc.dart';
import '../../data/check_user_exists.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginCubitState> {
  LoginCubit() : super(LoginCubitState(loginSuccess: false));
  checkUserExists(String userName, String passWord) async {
    bool res =  await UserExists().fetchADUserData(userName, passWord);
    print(res);
    emit(LoginCubitState(loginSuccess: res));
  }
}
