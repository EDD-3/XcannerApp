import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class Chain extends Equatable {
  //Atributos de la entidad
  final int id;
  final String chainName;

  //Constructor
  Chain({
    this.id,
    @required this.chainName
  });
  // Lista de elementos para Equatable
  @override
  List<Object> get props =>
      [id, chainName];
}