import 'package:bloc/bloc.dart';
import 'package:PayFace/bloc/history/history_event.dart';
import 'package:PayFace/bloc/history/history_state.dart';
import 'package:PayFace/repository/user_repo.dart';
import 'package:PayFace/bloc/auth/auth_bloc.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  
  final BaseUserRepo userRepo;
  final AuthBloc authBloc;

  HistoryBloc({this.userRepo, this.authBloc});
  
  
  HistoryState get initialState => HistoryLoaded();

  @override
  Stream<HistoryState> mapEventToState(HistoryEvent event) async* {
   
  }

}