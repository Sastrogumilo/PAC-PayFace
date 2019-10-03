import 'package:bloc/bloc.dart';
import 'package:PayFace/bloc/login/login_event.dart';
import 'package:PayFace/bloc/login/login_state.dart';
import 'package:PayFace/bloc/auth/auth_bloc.dart';
import 'package:PayFace/bloc/auth/auth_event.dart';
import 'package:PayFace/repository/user_repo.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final BaseUserRepo userRepo;
  final AuthBloc authBloc;

  LoginBloc({this.userRepo, this.authBloc}):
  assert(userRepo != null), 
  assert(authBloc != null);

  @override 
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        final user = await userRepo.authenticate(
          username: event.username,
          //email: event.email,
          password: event.password,
        );
        if (user != null) {
          authBloc.dispatch(LoggedIn(user: user));
        } else {
          yield LoginGagal(error: 'LoginGagal');
        }
      } catch (error) {
        yield LoginGagal(error: error.toString());
      }
    }
  }

}