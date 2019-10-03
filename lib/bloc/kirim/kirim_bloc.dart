
import 'package:bloc/bloc.dart';
import 'package:PayFace/bloc/kirim/kirim_event.dart';
import 'package:PayFace/bloc/kirim/kirim_state.dart';
import 'package:PayFace/repository/user_repo.dart';
import 'package:PayFace/bloc/auth/auth_bloc.dart';

class KirimBloc extends Bloc<KirimEvent, KirimState> {
  
  final BaseUserRepo userRepo;
  final AuthBloc authBloc;

  KirimBloc({this.userRepo, this.authBloc});
  
  
  KirimState get initialState => KirimLoaded();

  @override
  Stream<KirimState> mapEventToState(KirimEvent event) async* {
   
  }

}