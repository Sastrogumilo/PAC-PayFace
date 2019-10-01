import 'package:PayFace/bloc/register/register_event.dart';
import 'package:PayFace/bloc/register/register_state.dart';
import 'package:PayFace/repository/user_repo.dart';
import 'package:PayFace/bloc/auth/auth_bloc.dart';
import 'package:PayFace/bloc/auth/auth_event.dart';
import 'package:bloc/bloc.dart';


class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  final BaseUserRepo userRepo;
  final AuthBloc authBloc;

  RegisterBloc({this.userRepo, this.authBloc}):
  assert(userRepo != null),
  assert(authBloc != null);

  @override 
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async*{
    if (event is TombolRegister) {
      yield RegisterLoading();
      try {
          final user = await userRepo.register(
            username: event.username,
            email: event.email,
            password: event.password
          );
          if (user != null) {
            yield RegisterBerhasil();
            authBloc.dispatch(LoggedIn(user: user));
          } else {
            yield RegisterGagal(error: 'RegistrasiGagal');
          }
          } catch (error) {
            yield RegisterGagal(error: error.toString());

      } finally {
        yield RegisterBerhasil();
      }
    }
  }

   
}

