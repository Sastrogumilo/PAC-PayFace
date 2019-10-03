
import 'package:PayFace/bloc/auth/auth_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:PayFace/bloc/pin/pin_event.dart';
import 'package:PayFace/bloc/pin/pin_state.dart';
import 'package:PayFace/repository/user_repo.dart';


class PinBloc extends Bloc<PinEvent, PinState> {
  
  final BaseUserRepo userRepo;
  final AuthBloc authBloc;

  PinBloc({this.userRepo, this.authBloc});
  
  
  PinState get initialState => PinLoaded();

  @override
  Stream<PinState> mapEventToState(PinEvent event) async* {
   
  }

}