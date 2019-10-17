
import 'package:PayFace/bloc/auth/auth_bloc.dart';
import 'package:PayFace/bloc/datadiri/datadiri_event.dart';
import 'package:PayFace/bloc/datadiri/datadiri_state.dart';
import 'package:PayFace/repository/datadiri_repo.dart';
import 'package:PayFace/repository/user_repo.dart';
import 'package:bloc/bloc.dart';

class DataDiriBloc extends Bloc<DataDiriEvent, DataDiriState>{
  final DataRepo dataRepo;
  final AuthBloc authBloc;
  final UserRepo userRepo;
  

  DataDiriBloc({this.dataRepo, this.authBloc, this.userRepo});


  @override 
  DataDiriState get initialState => DataDiriInitial();

  @override
  Stream<DataDiriState> mapEventToState(DataDiriEvent event) async*{
    if (event is TombolSaveData) {
      yield DataDiriLoading();
      try {

          final dataHasil = await dataRepo.dataTambahan(
              alamat: event.alamat,
              notlp: event.notlp,
              namalengkap: event.namalengkap,
              email: event.email,
              password: event.password,
              username: event.username,

            );

        if (dataHasil != null) {
          yield DataDiriBerhasil();

        } else {
        yield DataDiriGagal(error: 'Input Data Gagal');
        }

        } catch (error) {
          yield DataDiriGagal(error: error.toString());
      
      }
      
    }


  }

  

}