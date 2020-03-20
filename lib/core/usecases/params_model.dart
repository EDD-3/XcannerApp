import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:xcanner_app/features/chains/domain/entities/chain.dart';

class ParamsModel extends Equatable {
  final Chain model;

  ParamsModel({
    @required this.model,
  });

  @override
  List<Object> get props => [model];
}