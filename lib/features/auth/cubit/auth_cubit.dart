import 'package:all_event/constant/global.dart';
import 'package:all_event/repository/app_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());
  final _repo = AppRepo();

  void signIn() async {
    try {
      emit(state.copyWith(apiState: ApiState.loading));
      final user = await _repo.signIn();
      print("Login Success::: ${user.toString()}");
      emit(state.copyWith(apiState: ApiState.loaded));
    } catch (e) {
      print(e.toString());
      emit(state.copyWith(apiState: ApiState.error, error: e.toString()));
    }
  }
}
