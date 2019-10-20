
import 'package:PayFace/bloc/auth/auth_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:PayFace/bloc/kamera_cari/kameraCari_event.dart';
import 'package:PayFace/bloc/kamera_cari/kameraCari_state.dart';
import 'package:PayFace/repository/user_repo.dart';

class KameraBayarBloc extends Bloc<KameraCariEvent, KameraCariState> {
  
  final BaseUserRepo userRepo;
  final AuthBloc authBloc;

  KameraBayarBloc({this.userRepo, this.authBloc});
  
  
  KameraCariState get initialState => KameraCariLoaded();

  @override
  Stream<KameraCariState> mapEventToState(KameraCariEvent event) async* {
   
  }

}