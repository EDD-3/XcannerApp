import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:xcanner_app/core/errors/exceptions.dart';
import 'package:xcanner_app/features/chains/data/models/chain_model.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:get_ip/get_ip.dart';

abstract class ChainRemoteDatasource {
  Future<List<ChainModel>> getChainList();
  Future<ChainModel> getChain(int id);
}

class ChainRemoteDatasourceImpl implements ChainRemoteDatasource {
  final http.Client client;

  ChainRemoteDatasourceImpl({
    @required this.client,
  });

  @override
  Future<List<ChainModel>> getChainList() async {
    List<ChainModel> list = List<ChainModel>();

    list.add(ChainModel(chainName: 'Safeway', id: 1));

    return Future.delayed(Duration(seconds: 3), () => list);

    String ipAddress = await GetIp.ipAddress;
    final url = Platform.isAndroid
        ? 'http://$ipAddress/api/categories'
        : 'http://localhost:4444/api/categories';

    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );
    switch (response.statusCode) {
      case 200:
        final result = jsonDecode(response.body);
        final Iterable list = result;
        return list.map((model) => ChainModel.fromJson(model)).toList();

      default:
        throw ServerException(
          code: response.statusCode,
          message: response.reasonPhrase,
        );
    }
  }

  @override
  Future<ChainModel> getChain(int id) async {

    List<ChainModel> list = List<ChainModel>();
    ChainModel model1 = ChainModel(chainName: 'Safeway', id: 1);
    ChainModel model2 = ChainModel(chainName: 'Walmart', id: 2);
    list.add(model1);
    list.add(model2);
    ChainModel result = list.firstWhere((model) => model.id == id, orElse:() => null);
    return Future.delayed(Duration(seconds: 2), () => result);

    final url = Platform.isAndroid
        ? 'http://192.168.0.10:4444/api/category/$id'
        : 'http://localhost:4444/api/category/$id';

    final response = await client.get(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    switch (response.statusCode) {
      case 200:
        final result = jsonDecode(response.body);
        return ChainModel.fromJson(result);
      default:
        throw ServerException(
          code: response.statusCode,
          message: response.reasonPhrase,
        );
    }
  }
}
