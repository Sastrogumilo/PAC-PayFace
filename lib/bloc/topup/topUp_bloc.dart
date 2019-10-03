
import 'package:PayFace/bloc/auth/auth_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:PayFace/bloc/topup/topUp_event.dart';
import 'package:PayFace/bloc/topup/topUp_state.dart';
import 'package:PayFace/repository/user_repo.dart';


class TopUpBloc extends Bloc<TopUpEvent, TopUpState> {
  
  final BaseUserRepo userRepo;
  final AuthBloc authBloc;
 
  TopUpBloc({this.userRepo, this.authBloc});
  
  
  TopUpState get initialState => TopUpLoaded();

  @override
  Stream<TopUpState> mapEventToState(TopUpEvent event) async* {
   
  }

}