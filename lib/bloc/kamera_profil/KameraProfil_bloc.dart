
import 'package:PayFace/bloc/auth/auth_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:PayFace/bloc/kamera_profil/KameraProfil_event.dart';
import 'package:PayFace/bloc/kamera_profil/KameraProfil_state.dart';
import 'package:PayFace/repository/user_repo.dart';


class KameraProfilBloc extends Bloc<KameraProfilEvent, KameraProfilState> {
  
  final BaseUserRepo userRepo;
  final AuthBloc authBloc;

  KameraProfilBloc({this.userRepo, this.authBloc});
  
  
  KameraProfilState get initialState => KameraProfilLoaded();

  @override
  Stream<KameraProfilState> mapEventToState(KameraProfilEvent event) async* {
   
  }

}