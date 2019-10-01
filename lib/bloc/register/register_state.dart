import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


 abstract class RegisterState extends Equatable {
   RegisterState([List props = const[]]):super([props]);

 }

 class RegisterInitial extends RegisterState{
   @override 
   String toString() => 'RegisterInitial';

 }

 class RegisterLoading extends RegisterState{

   @override 
   String toString() => 'RegisterLoading';
 }

 class RegisterGagal extends RegisterState{

   final String error;
   RegisterGagal({@required this.error}):super([error]);

   @override 
   String toString() => 'RegisterGagal {error: $error}';
 }

 class RegisterBerhasil extends RegisterState{

   @override
   String toString() => 'RegisterBerhasil';
 }