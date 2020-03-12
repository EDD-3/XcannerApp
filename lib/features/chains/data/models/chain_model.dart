import 'package:xcanner_app/features/chains/domain/entities/chain.dart';
import 'package:meta/meta.dart';

class ChainModel extends Chain {
  ChainModel({
    @required int id,
    @required String chainName,
  }) : super(
          chainName: chainName,
          id: id,
        );

  factory ChainModel.fromJson(Map<String, dynamic> json) {
    return ChainModel(
      id: json['id'],
      chainName: json['chain_name'],
    );
  }

  Map<String,dynamic> toJson() {
    return {
      'id':id,
      'chain_name': chainName,
    };
  }
}
