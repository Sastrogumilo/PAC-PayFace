import 'package:PayFace/component/kamera_bayar.dart';
import 'package:flutter/material.dart';
import 'package:PayFace/bloc/kirim/kirim_bloc.dart';
import 'package:PayFace/bloc/kirim/kirim_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:PayFace/bloc/auth/auth_bloc.dart';
import 'package:PayFace/bloc/kamera_bayar/kameraBayar_bloc.dart';


class ColorPalete {
  static const backgroundColor = Color(0xff0066ff) ;
  static const backgroundColorDark = Color(0xff67b1);
  static const underLineTextInput = Color(0xffabbadb);
  static const hintInput = Color(0xfffff);
}

class KirimPage extends StatefulWidget {
  static String tag = 'kirim-page';
  @override 
  _KirimPageState createState() => _KirimPageState();
  
}

class _KirimPageState extends State<KirimPage> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating =  false;
  String _jumlah;
  
  KirimBloc _kirimBloc;


  final pageKirim = Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      SizedBox(height: 0,),
      Padding(
        padding: new EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            prefixText: '\Rp ',
            suffixText: 'RPH',
            labelText: 'Jumlah Uang',
            suffixStyle: TextStyle(color: Colors.green),
            fillColor: Colors.white30,
            icon:Icon(Icons.attach_money),
          ),
          maxLines: 1,
          keyboardType: TextInputType.number,
          //onSaved: (String value) => this._jumlah = value,
        ),
      ),
  
      const Divider(height: 400),
      
      new RaisedButton(
        elevation: 0,
        color: Colors.white,
        padding: EdgeInsets.all(0),
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14),
          width: double.infinity,
          child: Text('Scan Wajah',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(32)
          ),
        ),
      ),
    ]
  );

  @override
  Widget build(BuildContext context) {
   _kirimBloc = BlocProvider.of<KirimBloc>(context);
    return BlocBuilder<KirimBloc, KirimState>(
      bloc: _kirimBloc,
      builder: (context, state){


    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: 
          _loadKameraBayarPage,
        label: Text('Scan Wajah'),
        icon: Icon(Icons.camera),
        backgroundColor: Colors.orange,
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            snap:false,
            floating: false,
            expandedHeight: 180.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Transfer'),
              background: Image.asset(
                'asset/images/logo.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          SliverFillRemaining(
            child: pageKirim
          )
        ],
      ) 
    );
  }
  );
  }

  void _loadKameraBayarPage() {
  Navigator.push(context, 
      MaterialPageRoute(builder: (context){
        return BlocProvider<KameraBayarBloc>(
          builder: (context) {
            return KameraBayarBloc(authBloc: BlocProvider.of<AuthBloc>(context),
            userRepo:   _kirimBloc.userRepo,
            );
          },
          child: KameraBayarPage(),

        );
      }
      )
  );
}

}