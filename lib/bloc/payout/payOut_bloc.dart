
import 'package:PayFace/bloc/auth/auth_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:PayFace/bloc/payout/payOut_event.dart';
import 'package:PayFace/bloc/payout/payOut_state.dart';
import 'package:PayFace/repository/user_repo.dart';


class PayOutBloc extends Bloc<PayOutEvent, PayOutState> {
  
  final BaseUserRepo userRepo;
  final AuthBloc authBloc;
  

  PayOutBloc({this.userRepo, this.authBloc});
  
  
  PayOutState get initialState => PayOutLoaded();

  @override
  Stream<PayOutState> mapEventToState(PayOutEvent event) async* {
   
  }

}