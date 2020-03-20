import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:xcanner_app/core/errors/exceptions.dart';
import 'package:xcanner_app/features/chains/data/models/chain_model.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

abstract class ChainRemoteDatasource {
  Future<List<ChainModel>> getChainList();
  Future<ChainModel> getChain(int id);
  Future<ChainModel> deleteChain(int id);
  Future<ChainModel> updateChain(ChainModel model);
  Future<ChainModel> insertChain(ChainModel model);
  
}

class ChainRemoteDatasourceImpl implements ChainRemoteDatasource {
  final http.Client client;

  ChainRemoteDatasourceImpl({
    @required this.client,
  });

  @override
  Future<List<ChainModel>> getChainList() async {

    final url = Platform.isAndroid
        ? 'http://192.168.0.7:4444/api/chains'
        : 'http://localhost:4444/api/chains';

    final response = await client.get(
      url,
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

    final url = Platform.isAndroid
        ? 'http://192.168.0.7:4444/api/chain/$id'
        : 'http://localhost:4444/api/chain/$id';

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

  @override
  Future<ChainModel> updateChain(ChainModel model) async {


    int id = model.id;
    Map<String, dynamic> body = model.toJson();
    body['id'] = id;
    final url = Platform.isAndroid
        ? 'http://192.168.0.7:4444/api/chain'
        : 'http://localhost:4444/api/chain';

    final response = await client.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body
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

  @override
  Future<ChainModel> insertChain(ChainModel model) async {

    final url = Platform.isAndroid
        ? 'http://192.168.0.7:4444/api/chain'
        : 'http://localhost:4444/api/chain';

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: model.toJson()
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

  @override
  Future<ChainModel> deleteChain(int id) async {
    final url = Platform.isAndroid
        ? 'http://192.168.0.7:4444/api/chain/$id'
        : 'http://localhost:4444/api/chain/$id';

    final response = await client.delete(
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
