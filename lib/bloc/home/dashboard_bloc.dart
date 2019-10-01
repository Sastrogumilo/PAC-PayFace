
import 'package:PayFace/repository/datadiri_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:PayFace/bloc/home/dashboard_event.dart';
import 'package:PayFace/bloc/home/dashboard_state.dart';
import 'package:PayFace/repository/user_repo.dart';


class DashBoardBloc extends Bloc<DashBoardEvent, DashBoardState> {
  
  final BaseUserRepo userRepo;
  final DataRepo dataRepo;

  DashBoardBloc({this.userRepo, this.dataRepo});
  
  
  DashBoardState get initialState => DashBoardLoaded();

  @override
  Stream<DashBoardState> mapEventToState(DashBoardEvent event) async* {
   
  }

}