
import 'package:PayFace/bloc/auth/auth_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:PayFace/bloc/konfirmasi/konfirmasi_event.dart';
import 'package:PayFace/bloc/konfirmasi/konfirmasi_state.dart';
import 'package:PayFace/repository/user_repo.dart';


class KonfirmasiBloc extends Bloc<KonfirmasiEvent, KonfirmasiState> {
  
  final BaseUserRepo userRepo;
  final AuthBloc authBloc;

  KonfirmasiBloc({this.userRepo, this.authBloc});
  
  
  KonfirmasiState get initialState => KonfirmasiLoaded();

  @override
  Stream<KonfirmasiState> mapEventToState(KonfirmasiEvent event) async* {
   
  }

}