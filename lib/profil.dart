<<<<<<< HEAD
import 'package:PayFace/kamera_profil.dart';
=======
>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
import 'package:flutter/material.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdownfield/dropdownfield.dart';

<<<<<<< HEAD
class ProfilPage extends StatefulWidget{
  static String tag = 'profil-tag';
=======

class ProfilPage extends StatefulWidget{
  static String tag = 'profil-tag';

>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
  @override 
  _ProfilPageState createState() => _ProfilPageState();
  
}

class _ProfilPageState extends State<ProfilPage> {
<<<<<<< HEAD
  //final _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwdFieldKey = new GlobalKey<FormFieldState<String>>();
  final format = DateFormat("yyyy-MM-dd");
  //DropDown Value
=======

  //final _formKey = GlobalKey<FormState>();  
  final format = DateFormat("yyyy-MM-dd");

  //DropDown Value 

>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
  Map<String, dynamic> formData;
  List<String> bank = [
    'BRI', 
    'BNI',
    'BCA',
    'BTN',
    'DLL'
  ];
<<<<<<< HEAD
  String _nama;
  String _email;
  String _notelp;
  String _passwd;

  String _validasiNama(String value)
  {
    if(value.isEmpty)return 'Belum mengisi nama';
    final RegExp nameExp = new RegExp(r'^[A-za-z ]+$');
    if(!nameExp.hasMatch(value))return 'Hanya bisa memasukan huruf dan angka';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final camera_button = FlatButton(
      color: Colors.lightBlue,
    );
    return Scaffold(
      appBar: new AppBar(
        title: const Text('Edit Profil'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.save),
          onPressed: () {}) //<-Di isi
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          children: <Widget>[
            // NAMA LENGKAP
            SizedBox(height: 12,),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white30,
                icon:Icon(Icons.person),
                hintText: "Siapa nama lengkap anda?",
                labelText: "Nama Lengkap"
              ),
              onSaved: (String value) => this._nama = value,
              validator: _validasiNama,
            ),

            // E-MAIL
            SizedBox(height: 12,),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white30,
                icon:Icon(Icons.email),
                hintText: "Email yang digunakan",
                labelText: "E-mail"
              ),
              onSaved: (String value) => this._email = value,
              keyboardType: TextInputType.emailAddress,
            ),

            // No Telp
            SizedBox(height: 12,),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white30,
                icon:Icon(Icons.phone),
                hintText: "No telepon yang digunakan",
                labelText: "No Telepon: 08965454627"
              ),
              onSaved: (String value) => this._notelp = value,
              keyboardType: TextInputType.phone,
            ),
            
            // ALAMAT
            SizedBox(height: 12,),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white30,
                icon:Icon(Icons.home),
                hintText: "Alamat rumah anda",
                labelText: "Alamat"
              ),
              maxLines: 3,
            ),

            // USERNAME
            SizedBox(height: 12,),
            TextFormField(
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white30,
                icon:Icon(Icons.supervised_user_circle),
                hintText: "Username yang diinginkan",
                labelText: "Username"
              ),
              onSaved: (String value) => this._nama = value,
              validator: _validasiNama,
            ),

            // PASSWORD
            SizedBox(height: 12,),
            PasswordField(
              fieldKey: _passwdFieldKey,
              helperText: 'tidak lebih dari 8 karakter',
              labelText: 'Password',
              onFieldSubmitted: (String value){
                setState(() {
                 this._passwd = value; 
                });
              },
            ),

            // RE-TYPE PASSWORD
            SizedBox(height: 12,),
            TextFormField(
              enabled: this._passwd != null && this._passwd.isNotEmpty,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                icon: Icon(Icons.lock_outline),
                labelText: 'Re-type Password'
              ),
              maxLength: 8,
              obscureText: true,
            ),
            SizedBox(height: 8,),
            new RaisedButton(
              elevation: 0,
              color: Colors.white,
              padding: EdgeInsets.all(0),
              onPressed: () {Navigator.pushNamed(context, KameraPage.tag);},
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
            camera_button,
          ],
        ),
      )
    );
  }
}

class PasswordField extends StatefulWidget
{
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField>
{
  bool _obscureText = true;

  @override
  Widget build(BuildContext context)
  {
    return new TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      maxLength: 8,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: new InputDecoration(
        fillColor: Colors.white30,
        border: const OutlineInputBorder(),
        filled: true,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        icon:Icon(Icons.lock),
        suffix: new GestureDetector(
          onTap: (){
            setState(() {
             _obscureText = !_obscureText; 
            });
          },
          child: new Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        )
      ),
    );
  }
}
=======
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

>>>>>>> 056f8a9fea71045512b607fe9ec2f4a110035f83
