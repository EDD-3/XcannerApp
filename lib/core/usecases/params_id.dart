import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ParamsID extends Equatable {
  final int id;

  ParamsID({
    @required this.id,
  });

  @override
  List<Object> get props => [id];
}