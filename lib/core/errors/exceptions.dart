import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ServerException implements Exception, Equatable {
  final int code;
  final String message;

  ServerException({@required this.code, @required this.message});

  @override
  List<Object> get props => [code, message];

  @override
  bool get stringify => throw UnimplementedError();
}
