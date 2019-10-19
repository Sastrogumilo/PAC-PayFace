import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PayFace/bloc/konfirmasi/konfirmasi_bloc.dart';
import 'package:PayFace/bloc/konfirmasi/konfirmasi_state.dart';
import 'package:PayFace/bloc/auth/auth_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:PayFace/component/pin.dart';
import 'package:PayFace/bloc/pin/pin_bloc.dart';


class KonfirmasiPage extends StatefulWidget{
  static String tag = 'konfirmasi-tag';
  @override 
  _KonfirmasiPageState createState() => _KonfirmasiPageState();
}

class _KonfirmasiPageState extends State<KonfirmasiPage> {
  KonfirmasiBloc _konfirmasiBloc;
  
  String namaPenerima;
  String emailPenerima;
  String noTelpPenerima;
  String alamatPenerima;
  
  loadDataPenerima() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    new Future.delayed(Duration.zero, ()=> setState(() {
      
      namaPenerima = (pref.getString('namaLengkapPenerima') ?? "Data Belum Diisi atau Data Kosong");
      emailPenerima = (pref.getString('emailPenerima') ?? "Data Belum Diisi atau Data Kosong");
      alamatPenerima = (pref.getString('alamatPenerima') ?? "Data Belum Diisi atau Data Kosong");
      noTelpPenerima = (pref.getString('notelpPenerima') ?? "Data Belum Diisi atau Data Kosong");
    
    }));
  }
  @override 
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 3), ()=> loadDataPenerima());
  }

  @override
  Widget build(BuildContext context) {
    _konfirmasiBloc = BlocProvider.of<KonfirmasiBloc>(context);

    return BlocListener<KonfirmasiBloc, KonfirmasiState>(
      listener: (context, state) {
        
      },
      child: BlocBuilder<KonfirmasiBloc, KonfirmasiState>(
        bloc: _konfirmasiBloc,
        builder: (context, state) {
          return Scaffold(
            appBar: new AppBar(
              title: const Text('Konfirmasi Penerima'),
            ),

            body: SingleChildScrollView(
              child: Form(
              child: Padding (
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: new Column(
                children: <Widget>[
                  //FOTO 
                  // NAMA LENGKAP
                  SizedBox(height: 12,),
                  TextField(
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      enabled: false,
                      fillColor: Colors.white30,
                      icon:Icon(Icons.person),
                      labelText: "$namaPenerima"
                      
                    ),
                    
                  ),

                  // E-MAIL
                  SizedBox(height: 12,),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      enabled: false,
                      fillColor: Colors.white30,
                      icon:Icon(Icons.email),
                      labelText: "$emailPenerima"
                    ),
                  ),

                  // No Telp
                  SizedBox(height: 12,),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      enabled: false,
                      fillColor: Colors.white30,
                      icon:Icon(Icons.phone),
                      labelText: "$noTelpPenerima"
                    ),
                  ),
                  
                  // ALAMAT
                  SizedBox(height: 12,),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      enabled: false,
                      fillColor: Colors.white30,
                      icon:Icon(Icons.home),
                      labelText: "$alamatPenerima",
                    ),
                    maxLines: 3,
                  ),
                  Padding(padding: EdgeInsets.all(20)),
                                    
                  new RaisedButton(
                    elevation: 0,
                    color: Colors.white,
                    padding: EdgeInsets.all(0),
                    onPressed: _loadPinPage,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      width: double.infinity,
                      child: Text('Konfirmasi',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(32)
                      ),
                    ),
                  ),
                ],
              ),
            )
          )));
        }
      )
    );
  }

  void _loadPinPage() {
  Navigator.push(context, 
      MaterialPageRoute(builder: (context){
        return BlocProvider<PinBloc>(
          builder: (context) {
            return PinBloc(authBloc: BlocProvider.of<AuthBloc>(context),
            userRepo: _konfirmasiBloc.userRepo,
            );
          },
          child: PinPage(),

        );
      }
      )
  );
  }
}