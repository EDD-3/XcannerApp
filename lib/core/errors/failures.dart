import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];

  String getMessage();
}

class NetworkFailure implements Failure{
  final String message;

  NetworkFailure({@required this.message,});

  @override
  List<Object> get props => [message];

  @override
  String getMessage() {

    return message;
  }

}