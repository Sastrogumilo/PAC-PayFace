import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdownfield/dropdownfield.dart';


class ProfilPage extends StatefulWidget{
  static String tag = 'profil-tag';

  @override 
  _ProfilPageState createState() => _ProfilPageState();
  
}

class _ProfilPageState extends State<ProfilPage> {

  //final _formKey = GlobalKey<FormState>();  
  final format = DateFormat("yyyy-MM-dd");

  //DropDown Value 

  Map<String, dynamic> formData;
  List<String> bank = [
    'BRI', 
    'BNI',
    'BCA',
    'BTN',
    'DLL'
  ];
  @override
  
  Widget build(BuildContext context) {
    
  
  return Scaffold(

    appBar: new AppBar(
      title: const Text('Edit Profil'),
      actions: <Widget>[
        new IconButton(icon: const Icon(Icons.save),
        onPressed: () {}) //<-Di isi
      ],
    ),

    body: SingleChildScrollView(
      child: new Column(

      children: <Widget>[
        new ListTile( //<--------Nama
          leading: const Icon(Icons.person),
          title: new TextField(
            decoration: new InputDecoration(
              hintText: "Nama Lengkap"
            ),
          ),
        ),

        new ListTile( //<-------- Email
          leading: const Icon(Icons.email),
          title: new TextField(
            decoration: new InputDecoration(
              hintText: 'Email'
            ),
          ),
        ),
        const Divider(height: 10,
        ),

        new ListTile(
          leading: const Icon(Icons.home),
          title: new TextField(
            decoration: new InputDecoration(
              hintText: 'Alamat'
            ),
          ),
        ),

        new ListTile(
          leading: const Icon(Icons.supervised_user_circle),
          title: new TextField(
            decoration: new InputDecoration(
              hintText: 'Username'
            ),
          ),
        ),
        
        new ListTile(
          leading: const Icon(Icons.lock),
          title: new PasswordField(
            hintText: "Password",
          ),
        ),

        new ListTile(
          leading: const Icon(Icons.calendar_today),
          title: new DateTimeField(
            format: format,
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2200)
              );
            }
          )
        ),
        new DropDownField(
          value: null,
          icon: Icon(Icons.credit_card),
          required: true,
          hintText: 'Pilih Bank',
          items: bank,
          setter: (dynamic newValue) {
            formData['Bank'] = newValue;
          },
        ),
      new ListTile(
          leading: const Icon(Icons.confirmation_number),
          title: new TextField(
            decoration: new InputDecoration(
              hintText: 'Nomor Rekening'
            ),
          ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 16),
      ),
      new RaisedButton(
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          width: double.infinity,
          child: Text('Scan Wajah',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(30)
          
          ),
        ),
      ),   
      ],
    ),

    )
  );
    
  } 
    

}

