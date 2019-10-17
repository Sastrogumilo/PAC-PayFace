import 'package:PayFace/repository/user_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:PayFace/bloc/auth/auth_event.dart';
import 'package:PayFace/bloc/auth/auth_state.dart';
import 'package:meta/meta.dart';
import 'package:PayFace/model/deleteAllSharedPreference.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final BaseUserRepo userRepo;

  AuthBloc({@required this.userRepo}) : assert(userRepo != null);

  @override
  AuthState get initialState => AuthUninitial();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStart) {
      var user = await userRepo.currentUser();
      if (user != null) {
        yield AuthDikenal();

      } else {
        yield AuthUnauth();
      }
    }

    if (event is LoggedIn) {
      yield AuthDikenal();
    }

    if (event is LoggedOut) {
      yield AuthLoading();
      await userRepo.logout();
      deleteAllSharedPreference();
      yield AuthUnauth();
    }

  }
}
