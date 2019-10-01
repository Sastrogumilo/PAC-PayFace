
import 'package:PayFace/bloc/auth/auth_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:PayFace/bloc/kamera_bayar/kameraBayar_event.dart';
import 'package:PayFace/bloc/kamera_bayar/kameraBayar_state.dart';
import 'package:PayFace/repository/user_repo.dart';


class KameraBayarBloc extends Bloc<KameraBayarEvent, KameraBayarState> {
  
  final BaseUserRepo userRepo;
  final AuthBloc authBloc;

  KameraBayarBloc({this.userRepo, this.authBloc});
  
  
  KameraBayarState get initialState => KameraBayarLoaded();

  @override
  Stream<KameraBayarState> mapEventToState(KameraBayarEvent event) async* {
   
  }

}